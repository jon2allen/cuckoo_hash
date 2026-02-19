#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define TABLE_SIZE 500
#define MAX_MODELS 200
#define MAX_RETRIES 100
#define NUM_RUNS 10

typedef struct {
  char model_name[256];
  int num_used;
  char last_date_used[16];
} ModelEntry;

typedef struct {
  ModelEntry *table1[TABLE_SIZE];
  ModelEntry *table2[TABLE_SIZE];
  int count;
} CuckooTable;

// Simple hash functions
unsigned int hash1(const char *str) {
  unsigned int hash = 5381;
  int c;
  while ((c = *str++))
    hash = ((hash << 5) + hash) + c;
  return hash % TABLE_SIZE;
}

unsigned int hash2(const char *str) {
  unsigned int hash = 0;
  int c;
  while ((c = *str++))
    hash = c + (hash << 6) + (hash << 16) - hash;
  return hash % TABLE_SIZE;
}

void init_table(CuckooTable *t) {
  for (int i = 0; i < TABLE_SIZE; i++) {
    t->table1[i] = NULL;
    t->table2[i] = NULL;
  }
  t->count = 0;
}

bool insert(CuckooTable *t, ModelEntry *entry) {
  ModelEntry *current = entry;
  for (int i = 0; i < MAX_RETRIES; i++) {
    unsigned int h1 = hash1(current->model_name);
    if (t->table1[h1] == NULL) {
      t->table1[h1] = current;
      t->count++;
      return true;
    }

    // Evict and swap
    ModelEntry *temp = t->table1[h1];
    t->table1[h1] = current;
    current = temp;

    unsigned int h2 = hash2(current->model_name);
    if (t->table2[h2] == NULL) {
      t->table2[h2] = current;
      t->count++;
      return true;
    }

    // Evict and swap
    temp = t->table2[h2];
    t->table2[h2] = current;
    current = temp;
  }
  return false; // Rehash needed (not implemented for this testbed)
}

int main() {
  // 1. Load data from CSV
  FILE *fp = fopen("models_test_data.csv", "r");
  if (!fp) {
    perror("Could not open CSV");
    return 1;
  }

  ModelEntry all_models[MAX_MODELS];
  char line[512];
  int model_count = 0;

  fgets(line, sizeof(line), fp); // skip header
  while (fgets(line, sizeof(line), fp) && model_count < MAX_MODELS) {
    line[strcspn(line, "\r\n")] = 0;
    char *token = strtok(line, ",");
    if (token)
      strncpy(all_models[model_count].model_name, token, 255);
    token = strtok(NULL, ",");
    if (token)
      all_models[model_count].num_used = atoi(token);
    token = strtok(NULL, ",");
    if (token)
      strncpy(all_models[model_count].last_date_used, token, 15);
    model_count++;
  }
  fclose(fp);

  printf("Starting Cuckoo Hashing Testbed (Total Capacity: %d slots in 2 "
         "tables)\n",
         TABLE_SIZE * 2);
  printf("Inserting %d models, %d times each...\n\n", model_count, NUM_RUNS);

  double total_time = 0;
  int success_count = 0;
  float total_load_factor = 0;

  for (int r = 0; r < NUM_RUNS; r++) {
    CuckooTable t;
    init_table(&t);

    clock_t start = clock();
    int inserted_in_run = 0;
    for (int i = 0; i < model_count; i++) {
      if (insert(&t, &all_models[i])) {
        inserted_in_run++;
      }
    }
    clock_t end = clock();

    double time_taken = (double)(end - start) / CLOCKS_PER_SEC;
    float load_factor = (float)t.count / (TABLE_SIZE * 2);

    total_time += time_taken;
    total_load_factor += load_factor;
    if (inserted_in_run == model_count)
      success_count++;

    printf("Run %2d: Time = %.6f s, Load Factor = %.4f, Inserted = %d/%d\n",
           r + 1, time_taken, load_factor, inserted_in_run, model_count);
  }

  printf("\n--- Final Results ---\n");
  printf("Average Time: %.6f s\n", total_time / NUM_RUNS);
  printf("Average Load Factor: %.4f\n", total_load_factor / NUM_RUNS);
  printf("Full Success Ratio: %d/%d runs\n", success_count, NUM_RUNS);

  return 0;
}

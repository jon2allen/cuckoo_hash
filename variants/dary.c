#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define TOTAL_SLOTS 402
#define D 3
#define TABLE_SIZE (TOTAL_SLOTS / D)
#define MAX_RETRIES 100
#define NUM_RUNS 10
#define MAX_MODELS 200

typedef struct {
  char model_name[256];
  int num_used;
  char last_date_used[16];
} ModelEntry;

typedef struct {
  ModelEntry *table[D][TABLE_SIZE];
  int count;
  long total_displacements;
} CuckooTable;

unsigned int hash(const char *str, int type) {
  unsigned int h = 0;
  if (type == 0)
    h = 5381;
  else if (type == 1)
    h = 0;
  else
    h = 131;
  int c;
  while ((c = *str++)) {
    if (type == 0)
      h = ((h << 5) + h) + c;
    else if (type == 1)
      h = c + (h << 6) + (h << 16) - h;
    else
      h = (h << 5) + h + c;
  }
  return h % TABLE_SIZE;
}

bool verbose = false;

void init_table(CuckooTable *t) {
  memset(t->table, 0, sizeof(t->table));
  t->count = 0;
  t->total_displacements = 0;
}

bool insert(CuckooTable *t, ModelEntry *entry) {
  ModelEntry *current = entry;
  for (int i = 0; i < MAX_RETRIES; i++) {
    for (int d = 0; d < D; d++) {
      unsigned int h = hash(current->model_name, d);
      if (t->table[d][h] == NULL) {
        t->table[d][h] = current;
        t->count++;
        if (verbose) {
          printf("Inserted '%s' into table %d at index %u\n",
                 current->model_name, d, h);
        }
        return true;
      }
      t->total_displacements++;
      ModelEntry *temp = t->table[d][h];
      t->table[d][h] = current;
      current = temp;
    }
  }
  return false;
}

int main(int argc, char *argv[]) {
  for (int i = 1; i < argc; i++) {
    if (strcmp(argv[i], "-v") == 0)
      verbose = true;
  }
  FILE *fp = fopen("../models_test_data.csv", "r");
  if (!fp)
    return 1;
  ModelEntry models[MAX_MODELS];
  char line[512];
  int count = 0;
  fgets(line, sizeof(line), fp);
  while (fgets(line, sizeof(line), fp) && count < MAX_MODELS) {
    line[strcspn(line, "\r\n")] = 0;
    char *tok = strtok(line, ",");
    if (tok)
      strcpy(models[count].model_name, tok);
    tok = strtok(NULL, ",");
    if (tok)
      models[count].num_used = atoi(tok);
    tok = strtok(NULL, ",");
    if (tok)
      strcpy(models[count].last_date_used, tok);
    count++;
  }
  fclose(fp);

  double total_time = 0;
  float total_lf = 0;
  long all_displacements = 0;
  for (int r = 0; r < NUM_RUNS; r++) {
    CuckooTable t;
    init_table(&t);
    clock_t start = clock();
    for (int i = 0; i < count; i++)
      insert(&t, &models[i]);
    clock_t end = clock();
    total_time += (double)(end - start) / CLOCKS_PER_SEC;
    total_lf += (float)t.count / TOTAL_SLOTS;
    all_displacements += t.total_displacements;
  }
  printf("d-ary Cuckoo (d=3): AvgTime=%.8f, AvgLF=%.4f, AvgDisp=%.2f\n",
         total_time / NUM_RUNS, total_lf / NUM_RUNS,
         (double)all_displacements / NUM_RUNS);
  return 0;
}

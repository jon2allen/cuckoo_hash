#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_MODELS 256
#define MAX_LINE 512

typedef struct {
    char model_name[256];
    int num_used;
    char last_date_used[16];
} ModelEntry;

int compare_num_used(const void* a, const void* b) {
    ModelEntry* entryA = (ModelEntry*)a;
    ModelEntry* entryB = (ModelEntry*)b;
    return entryA->num_used - entryB->num_used;
}

int main() {
    FILE* fp = fopen("models_test_data.csv", "r");
    if (!fp) {
        perror("Could not open file");
        return 1;
    }

    ModelEntry models[MAX_MODELS];
    char line[MAX_LINE];
    int count = 0;

    // Skip header
    if (fgets(line, sizeof(line), fp) == NULL) {
        fclose(fp);
        return 0;
    }

    while (fgets(line, sizeof(line), fp) && count < MAX_MODELS) {
        // Remove newline
        line[strcspn(line, "\r\n")] = 0;

        char* token;
        // Model Name
        token = strtok(line, ",");
        if (!token) continue;
        strncpy(models[count].model_name, token, sizeof(models[count].model_name) - 1);

        // Num Used
        token = strtok(NULL, ",");
        if (!token) continue;
        models[count].num_used = atoi(token);

        // Last Date Used
        token = strtok(NULL, ",");
        if (!token) continue;
        strncpy(models[count].last_date_used, token, sizeof(models[count].last_date_used) - 1);

        count++;
    }

    fclose(fp);

    // Sort by num_used
    qsort(models, count, sizeof(ModelEntry), compare_num_used);

    // Print results
    printf("%-50s | %-10s | %-15s\n", "Model Name", "Num Used", "Last Date Used");
    printf("------------------------------------------------------------------------------------------\n");
    for (int i = 0; i < count; i++) {
        printf("%-50s | %-10d | %-15s\n", models[i].model_name, models[i].num_used, models[i].last_date_used);
    }

    return 0;
}

pub const CrossDatasetTypes = enum {
    all_datasets,
    single_dataset,

    pub const json_field_names = .{
        .all_datasets = "ALL_DATASETS",
        .single_dataset = "SINGLE_DATASET",
    };
};

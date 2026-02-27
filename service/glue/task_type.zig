pub const TaskType = enum {
    evaluation,
    labeling_set_generation,
    import_labels,
    export_labels,
    find_matches,

    pub const json_field_names = .{
        .evaluation = "EVALUATION",
        .labeling_set_generation = "LABELING_SET_GENERATION",
        .import_labels = "IMPORT_LABELS",
        .export_labels = "EXPORT_LABELS",
        .find_matches = "FIND_MATCHES",
    };
};

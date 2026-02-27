pub const RestoreTestingRecoveryPointSelectionAlgorithm = enum {
    latest_within_window,
    random_within_window,

    pub const json_field_names = .{
        .latest_within_window = "LATEST_WITHIN_WINDOW",
        .random_within_window = "RANDOM_WITHIN_WINDOW",
    };
};

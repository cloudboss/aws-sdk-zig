pub const HyperParameterTuningJobWarmStartType = enum {
    identical_data_and_algorithm,
    transfer_learning,

    pub const json_field_names = .{
        .identical_data_and_algorithm = "IDENTICAL_DATA_AND_ALGORITHM",
        .transfer_learning = "TRANSFER_LEARNING",
    };
};

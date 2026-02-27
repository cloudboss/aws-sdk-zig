pub const UpdateDataRetentionOperation = enum {
    increase_data_retention,
    decrease_data_retention,

    pub const json_field_names = .{
        .increase_data_retention = "INCREASE_DATA_RETENTION",
        .decrease_data_retention = "DECREASE_DATA_RETENTION",
    };
};

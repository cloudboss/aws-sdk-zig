pub const HttpEndpointS3BackupMode = enum {
    failed_data_only,
    all_data,

    pub const json_field_names = .{
        .failed_data_only = "FailedDataOnly",
        .all_data = "AllData",
    };
};

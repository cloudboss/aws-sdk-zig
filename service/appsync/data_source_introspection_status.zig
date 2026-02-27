pub const DataSourceIntrospectionStatus = enum {
    processing,
    failed,
    success,

    pub const json_field_names = .{
        .processing = "PROCESSING",
        .failed = "FAILED",
        .success = "SUCCESS",
    };
};

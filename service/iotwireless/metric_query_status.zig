pub const MetricQueryStatus = enum {
    succeeded,
    failed,

    pub const json_field_names = .{
        .succeeded = "Succeeded",
        .failed = "Failed",
    };
};

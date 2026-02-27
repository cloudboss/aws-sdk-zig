pub const AggregatedSourceStatusType = enum {
    failed,
    succeeded,
    outdated,

    pub const json_field_names = .{
        .failed = "FAILED",
        .succeeded = "SUCCEEDED",
        .outdated = "OUTDATED",
    };
};

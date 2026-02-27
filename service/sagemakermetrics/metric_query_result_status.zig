pub const MetricQueryResultStatus = enum {
    complete,
    truncated,
    internal_error,
    validation_error,

    pub const json_field_names = .{
        .complete = "COMPLETE",
        .truncated = "TRUNCATED",
        .internal_error = "INTERNAL_ERROR",
        .validation_error = "VALIDATION_ERROR",
    };
};

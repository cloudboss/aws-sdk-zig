pub const CloudWatchMetricDataStatusCode = enum {
    complete,
    internal_error,
    partial_data,

    pub const json_field_names = .{
        .complete = "COMPLETE",
        .internal_error = "INTERNAL_ERROR",
        .partial_data = "PARTIAL_DATA",
    };
};

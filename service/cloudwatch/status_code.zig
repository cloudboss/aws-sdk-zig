pub const StatusCode = enum {
    complete,
    internal_error,
    partial_data,
    forbidden,

    pub const json_field_names = .{
        .complete = "COMPLETE",
        .internal_error = "INTERNAL_ERROR",
        .partial_data = "PARTIAL_DATA",
        .forbidden = "FORBIDDEN",
    };
};

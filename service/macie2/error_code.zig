/// The source of an issue or delay. Possible values are:
pub const ErrorCode = enum {
    client_error,
    internal_error,

    pub const json_field_names = .{
        .client_error = "ClientError",
        .internal_error = "InternalError",
    };
};

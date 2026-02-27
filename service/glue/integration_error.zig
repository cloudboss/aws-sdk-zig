/// An error associated with a zero-ETL integration.
pub const IntegrationError = struct {
    /// The code associated with this error.
    error_code: ?[]const u8,

    /// A message describing the error.
    error_message: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
    };
};

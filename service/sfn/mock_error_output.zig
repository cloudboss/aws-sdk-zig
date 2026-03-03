/// A JSON object that contains a mocked error.
pub const MockErrorOutput = struct {
    /// A string containing the cause of the exception thrown when executing the
    /// state's logic.
    cause: ?[]const u8 = null,

    /// A string denoting the error code of the exception thrown when invoking the
    /// tested state. This field is required if `mock.errorOutput` is specified.
    @"error": ?[]const u8 = null,

    pub const json_field_names = .{
        .cause = "cause",
        .@"error" = "error",
    };
};

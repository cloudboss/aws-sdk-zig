/// Represents a failure a contributor insights operation.
pub const FailureException = struct {
    /// Description of the failure.
    exception_description: ?[]const u8 = null,

    /// Exception name.
    exception_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .exception_description = "ExceptionDescription",
        .exception_name = "ExceptionName",
    };
};

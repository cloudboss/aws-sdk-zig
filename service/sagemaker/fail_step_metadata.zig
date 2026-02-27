/// The container for the metadata for Fail step.
pub const FailStepMetadata = struct {
    /// A message that you define and then is processed and rendered by the Fail
    /// step when the error occurs.
    error_message: ?[]const u8,

    pub const json_field_names = .{
        .error_message = "ErrorMessage",
    };
};

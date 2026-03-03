/// Contains detailed error information explaining why an operation failed,
/// including which field caused the error and the reason for the failure.
pub const ErrorDetail = struct {
    /// The name of the field that contains an error or warning.
    field: ?[]const u8 = null,

    /// A detailed description of the error or warning.
    reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .field = "field",
        .reason = "reason",
    };
};

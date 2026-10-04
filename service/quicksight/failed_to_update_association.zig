/// Information about a per-ARN failure when updating agent associations.
pub const FailedToUpdateAssociation = struct {
    /// The ARN that could not be added or removed.
    arn: ?[]const u8 = null,

    /// The error code for the failure.
    error_code: ?[]const u8 = null,

    /// A description of the failure.
    error_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
    };
};

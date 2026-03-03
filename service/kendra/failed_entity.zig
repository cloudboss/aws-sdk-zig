/// Information on the users or groups in your IAM Identity Center identity
/// source that failed to properly configure with your Amazon Kendra experience.
pub const FailedEntity = struct {
    /// The identifier of the user or group in your IAM Identity Center identity
    /// source. For example, a user ID could be an email.
    entity_id: ?[]const u8 = null,

    /// The reason the user or group in your IAM Identity Center identity source
    /// failed to properly configure with your Amazon Kendra experience.
    error_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .entity_id = "EntityId",
        .error_message = "ErrorMessage",
    };
};

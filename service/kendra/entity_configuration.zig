const EntityType = @import("entity_type.zig").EntityType;

/// Provides the configuration information for users or groups in
/// your IAM Identity Center identity source to grant access your Amazon Kendra
/// experience.
pub const EntityConfiguration = struct {
    /// The identifier of a user or group in your IAM Identity Center identity
    /// source. For example, a user ID could be an email.
    entity_id: []const u8,

    /// Specifies whether you are configuring a `User` or a
    /// `Group`.
    entity_type: EntityType,

    pub const json_field_names = .{
        .entity_id = "EntityId",
        .entity_type = "EntityType",
    };
};

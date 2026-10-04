const AuthCodeEntityType = @import("auth_code_entity_type.zig").AuthCodeEntityType;

/// Contains the scope configuration for an authorization code. Defines the
/// permissions and access boundaries for
/// the session.
pub const AuthScope = struct {
    /// The name of the Customer Profiles domain to scope the session to.
    domain_name: ?[]const u8 = null,

    /// The identifier of the entity to scope the session to.
    entity_id: ?[]const u8 = null,

    /// The type of entity to scope the session to.
    entity_type: AuthCodeEntityType,

    /// The list of security profile identifiers to scope the session to. Maximum of
    /// 10 security profiles.
    security_profile_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .entity_id = "EntityId",
        .entity_type = "EntityType",
        .security_profile_ids = "SecurityProfileIds",
    };
};

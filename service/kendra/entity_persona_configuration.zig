const Persona = @import("persona.zig").Persona;

/// Provides the configuration information for users or groups in your
/// IAM Identity Center identity source for access to your Amazon Kendra
/// experience.
/// Specific permissions are defined for each user or group once they are
/// granted access to your Amazon Kendra experience.
pub const EntityPersonaConfiguration = struct {
    /// The identifier of a user or group in your IAM Identity Center identity
    /// source. For example, a user ID could be an email.
    entity_id: []const u8,

    /// The persona that defines the specific permissions of the user or group
    /// in your IAM Identity Center identity source. The available personas or
    /// access roles are `Owner` and `Viewer`. For more
    /// information on these personas, see [Providing
    /// access to your search
    /// page](https://docs.aws.amazon.com/kendra/latest/dg/deploying-search-experience-no-code.html#access-search-experience).
    persona: Persona,

    pub const json_field_names = .{
        .entity_id = "EntityId",
        .persona = "Persona",
    };
};

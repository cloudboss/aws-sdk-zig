const Persona = @import("persona.zig").Persona;

/// Summary information for users or groups in your IAM Identity Center identity
/// source. This applies to users and groups with specific permissions that
/// define
/// their level of access to your Amazon Kendra experience. You can create an
/// Amazon Kendra experience
/// such as a search application. For more information on creating a search
/// application
/// experience, see [Building a
/// search experience with no
/// code](https://docs.aws.amazon.com/kendra/latest/dg/deploying-search-experience-no-code.html).
pub const PersonasSummary = struct {
    /// The Unix timestamp when the summary information was created.
    created_at: ?i64,

    /// The identifier of a user or group in your IAM Identity Center identity
    /// source.
    /// For example, a user ID could be an email.
    entity_id: ?[]const u8,

    /// The persona that defines the specific permissions of the user or group in
    /// your IAM Identity Center identity source. The available personas or access
    /// roles are `Owner` and `Viewer`. For more information on
    /// these personas, see [Providing
    /// access to your search
    /// page](https://docs.aws.amazon.com/kendra/latest/dg/deploying-search-experience-no-code.html#access-search-experience).
    persona: ?Persona,

    /// The Unix timestamp when the summary information was last updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .entity_id = "EntityId",
        .persona = "Persona",
        .updated_at = "UpdatedAt",
    };
};

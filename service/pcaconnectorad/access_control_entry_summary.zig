const AccessRights = @import("access_rights.zig").AccessRights;

/// Summary of group access control entries that allow or deny Active Directory
/// groups based on their
/// security identifiers (SIDs) from enrolling and/or autofenrolling with the
/// template.
pub const AccessControlEntrySummary = struct {
    /// Allow or deny an Active Directory group from enrolling and autoenrolling
    /// certificates issued against
    /// a template.
    access_rights: ?AccessRights,

    /// The date and time that the Access Control Entry was created.
    created_at: ?i64,

    /// Name of the Active Directory group. This name does not need to match the
    /// group name in Active Directory.
    group_display_name: ?[]const u8,

    /// Security identifier (SID) of the group object from Active Directory. The SID
    /// starts with
    /// "S-".
    group_security_identifier: ?[]const u8,

    /// The Amazon Resource Name (ARN) that was returned when you called
    /// [CreateTemplate](https://docs.aws.amazon.com/pca-connector-ad/latest/APIReference/API_CreateTemplate.html).
    template_arn: ?[]const u8,

    /// The date and time that the Access Control Entry was updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .access_rights = "AccessRights",
        .created_at = "CreatedAt",
        .group_display_name = "GroupDisplayName",
        .group_security_identifier = "GroupSecurityIdentifier",
        .template_arn = "TemplateArn",
        .updated_at = "UpdatedAt",
    };
};

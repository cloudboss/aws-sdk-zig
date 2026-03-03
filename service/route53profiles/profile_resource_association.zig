const ProfileStatus = @import("profile_status.zig").ProfileStatus;

/// The association between a Route 53 Profile and resources.
pub const ProfileResourceAssociation = struct {
    /// The date and time that the Profile resource association was created, in Unix
    /// time format and Coordinated Universal Time (UTC).
    creation_time: ?i64 = null,

    /// ID of the Profile resource association.
    id: ?[]const u8 = null,

    /// The date and time that the Profile resource association was modified, in
    /// Unix time format and Coordinated Universal Time (UTC).
    modification_time: ?i64 = null,

    /// Name of the Profile resource association.
    name: ?[]const u8 = null,

    /// Amazon Web Services account ID of the Profile resource association owner.
    owner_id: ?[]const u8 = null,

    /// Profile ID of the Profile that the resources are associated with.
    profile_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the resource association.
    resource_arn: ?[]const u8 = null,

    /// If the DNS resource is a DNS Firewall rule group, this indicates the
    /// priority.
    resource_properties: ?[]const u8 = null,

    /// Resource type, such as a private hosted zone, or DNS Firewall rule group.
    resource_type: ?[]const u8 = null,

    /// Status of the Profile resource association.
    status: ?ProfileStatus = null,

    /// Additional information about the Profile resource association.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .id = "Id",
        .modification_time = "ModificationTime",
        .name = "Name",
        .owner_id = "OwnerId",
        .profile_id = "ProfileId",
        .resource_arn = "ResourceArn",
        .resource_properties = "ResourceProperties",
        .resource_type = "ResourceType",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};

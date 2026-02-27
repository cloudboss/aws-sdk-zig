const ProfileStatus = @import("profile_status.zig").ProfileStatus;

/// An association between a Route 53 Profile and a VPC.
pub const ProfileAssociation = struct {
    /// The date and time that the Profile association was created, in Unix time
    /// format and Coordinated Universal Time (UTC).
    creation_time: ?i64,

    /// ID of the Profile association.
    id: ?[]const u8,

    /// The date and time that the Profile association was modified, in Unix time
    /// format and Coordinated Universal Time (UTC).
    modification_time: ?i64,

    /// Name of the Profile association.
    name: ?[]const u8,

    /// Amazon Web Services account ID of the Profile association owner.
    owner_id: ?[]const u8,

    /// ID of the Profile.
    profile_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the VPC.
    resource_id: ?[]const u8,

    /// Status of the Profile association.
    status: ?ProfileStatus,

    /// Additional information about the Profile association.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .id = "Id",
        .modification_time = "ModificationTime",
        .name = "Name",
        .owner_id = "OwnerId",
        .profile_id = "ProfileId",
        .resource_id = "ResourceId",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};

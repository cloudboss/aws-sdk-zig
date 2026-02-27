const ShareStatus = @import("share_status.zig").ShareStatus;
const ProfileStatus = @import("profile_status.zig").ProfileStatus;

/// A complex type that includes settings for a Route 53 Profile.
pub const Profile = struct {
    /// The Amazon Resource Name (ARN) of the Profile.
    arn: ?[]const u8,

    /// The `ClientToken` value that was assigned when the Profile was created.
    client_token: ?[]const u8,

    /// The date and time that the Profile was created, in Unix time format and
    /// Coordinated Universal Time (UTC).
    creation_time: ?i64,

    /// ID of the Profile.
    id: ?[]const u8,

    /// The date and time that the Profile was modified, in Unix time format and
    /// Coordinated Universal Time (UTC).
    modification_time: ?i64,

    /// Name of the Profile.
    name: ?[]const u8,

    /// Amazon Web Services account ID of the Profile owner.
    owner_id: ?[]const u8,

    /// Sharing status for the Profile.
    share_status: ?ShareStatus,

    /// The status for the Profile.
    status: ?ProfileStatus,

    /// Status message that includes additiona information about the Profile.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .client_token = "ClientToken",
        .creation_time = "CreationTime",
        .id = "Id",
        .modification_time = "ModificationTime",
        .name = "Name",
        .owner_id = "OwnerId",
        .share_status = "ShareStatus",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};

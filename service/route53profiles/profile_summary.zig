const ShareStatus = @import("share_status.zig").ShareStatus;

/// Summary information about a Route 53 Profile.
pub const ProfileSummary = struct {
    /// The Amazon Resource Name (ARN) of the Profile.
    arn: ?[]const u8 = null,

    /// ID of the Profile.
    id: ?[]const u8 = null,

    /// Name of the Profile.
    name: ?[]const u8 = null,

    /// Share status of the Profile.
    share_status: ?ShareStatus = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .name = "Name",
        .share_status = "ShareStatus",
    };
};

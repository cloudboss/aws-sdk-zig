const ShareStatus = @import("share_status.zig").ShareStatus;

/// Summary of a profile share.
pub const ProfileShareSummary = struct {
    shared_with: ?[]const u8 = null,

    share_id: ?[]const u8 = null,

    status: ?ShareStatus = null,

    /// Profile share invitation status message.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .shared_with = "SharedWith",
        .share_id = "ShareId",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};

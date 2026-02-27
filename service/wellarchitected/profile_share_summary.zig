const ShareStatus = @import("share_status.zig").ShareStatus;

/// Summary of a profile share.
pub const ProfileShareSummary = struct {
    shared_with: ?[]const u8,

    share_id: ?[]const u8,

    status: ?ShareStatus,

    /// Profile share invitation status message.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .shared_with = "SharedWith",
        .share_id = "ShareId",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};

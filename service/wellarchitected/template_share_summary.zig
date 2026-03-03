const ShareStatus = @import("share_status.zig").ShareStatus;

/// Summary of a review template share.
pub const TemplateShareSummary = struct {
    shared_with: ?[]const u8 = null,

    share_id: ?[]const u8 = null,

    status: ?ShareStatus = null,

    /// Review template share invitation status message.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .shared_with = "SharedWith",
        .share_id = "ShareId",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};

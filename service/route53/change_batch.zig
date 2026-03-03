const Change = @import("change.zig").Change;

/// The information for a change request.
pub const ChangeBatch = struct {
    /// Information about the changes to make to the record sets.
    changes: []const Change,

    /// *Optional:* Any comments you want to include about a change batch
    /// request.
    comment: ?[]const u8 = null,
};

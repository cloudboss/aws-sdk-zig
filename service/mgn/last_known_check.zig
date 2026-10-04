const LastKnownCheckStatus = @import("last_known_check_status.zig").LastKnownCheckStatus;
const LastKnownCheckType = @import("last_known_check_type.zig").LastKnownCheckType;

/// Last known check performed on a launched instance.
pub const LastKnownCheck = struct {
    /// Last known check timestamp.
    checked_at: ?i64 = null,

    /// Last known check error.
    @"error": ?[]const u8 = null,

    /// Last known check name.
    name: ?[]const u8 = null,

    /// Last known check status.
    status: ?LastKnownCheckStatus = null,

    /// Last known check type.
    @"type": ?LastKnownCheckType = null,

    pub const json_field_names = .{
        .checked_at = "checkedAt",
        .@"error" = "error",
        .name = "name",
        .status = "status",
        .@"type" = "type",
    };
};

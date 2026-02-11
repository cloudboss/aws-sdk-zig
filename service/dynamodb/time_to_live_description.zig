const TimeToLiveStatus = @import("time_to_live_status.zig").TimeToLiveStatus;

/// The description of the Time to Live (TTL) status on the specified table.
pub const TimeToLiveDescription = struct {
    /// The name of the TTL attribute for items in the table.
    attribute_name: ?[]const u8,

    /// The TTL status for the table.
    time_to_live_status: ?TimeToLiveStatus,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .time_to_live_status = "TimeToLiveStatus",
    };
};

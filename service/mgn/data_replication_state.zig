const std = @import("std");

pub const DataReplicationState = enum {
    stopped,
    initiating,
    initial_sync,
    backlog,
    creating_snapshot,
    continuous,
    paused,
    rescan,
    stalled,
    disconnected,
    pending_snapshot_shipping,
    shipping_snapshot,

    pub const json_field_names = .{
        .stopped = "STOPPED",
        .initiating = "INITIATING",
        .initial_sync = "INITIAL_SYNC",
        .backlog = "BACKLOG",
        .creating_snapshot = "CREATING_SNAPSHOT",
        .continuous = "CONTINUOUS",
        .paused = "PAUSED",
        .rescan = "RESCAN",
        .stalled = "STALLED",
        .disconnected = "DISCONNECTED",
        .pending_snapshot_shipping = "PENDING_SNAPSHOT_SHIPPING",
        .shipping_snapshot = "SHIPPING_SNAPSHOT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .stopped => "STOPPED",
            .initiating => "INITIATING",
            .initial_sync => "INITIAL_SYNC",
            .backlog => "BACKLOG",
            .creating_snapshot => "CREATING_SNAPSHOT",
            .continuous => "CONTINUOUS",
            .paused => "PAUSED",
            .rescan => "RESCAN",
            .stalled => "STALLED",
            .disconnected => "DISCONNECTED",
            .pending_snapshot_shipping => "PENDING_SNAPSHOT_SHIPPING",
            .shipping_snapshot => "SHIPPING_SNAPSHOT",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};

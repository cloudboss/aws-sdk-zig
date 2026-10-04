const std = @import("std");

/// Rtmp Cache Full Behavior
pub const RtmpCacheFullBehavior = enum {
    disconnect_immediately,
    wait_for_server,

    pub const json_field_names = .{
        .disconnect_immediately = "DISCONNECT_IMMEDIATELY",
        .wait_for_server = "WAIT_FOR_SERVER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disconnect_immediately => "DISCONNECT_IMMEDIATELY",
            .wait_for_server => "WAIT_FOR_SERVER",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};

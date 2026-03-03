const std = @import("std");

pub const HLSPlaybackMode = enum {
    live,
    live_replay,
    on_demand,

    pub const json_field_names = .{
        .live = "LIVE",
        .live_replay = "LIVE_REPLAY",
        .on_demand = "ON_DEMAND",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .live => "LIVE",
            .live_replay => "LIVE_REPLAY",
            .on_demand => "ON_DEMAND",
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

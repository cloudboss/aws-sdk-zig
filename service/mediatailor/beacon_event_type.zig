const std = @import("std");

/// A player operation event that MediaTailor can report on. Only the player can
/// detect when a viewer performs this action, so MediaTailor doesn't send these
/// beacons itself.
pub const BeaconEventType = enum {
    mute,
    unmute,
    pause,
    skip,

    pub const json_field_names = .{
        .mute = "MUTE",
        .unmute = "UNMUTE",
        .pause = "PAUSE",
        .skip = "SKIP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .mute => "MUTE",
            .unmute => "UNMUTE",
            .pause => "PAUSE",
            .skip => "SKIP",
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

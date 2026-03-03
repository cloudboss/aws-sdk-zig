const std = @import("std");

/// Scte35 Apos No Regional Blackout Behavior
pub const Scte35AposNoRegionalBlackoutBehavior = enum {
    follow,
    ignore,

    pub const json_field_names = .{
        .follow = "FOLLOW",
        .ignore = "IGNORE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .follow => "FOLLOW",
            .ignore => "IGNORE",
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

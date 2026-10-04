const std = @import("std");

/// Scte35 Splice Insert No Regional Blackout Behavior
pub const Scte35SpliceInsertNoRegionalBlackoutBehavior = enum {
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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};

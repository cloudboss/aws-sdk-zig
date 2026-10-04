const std = @import("std");

pub const DiscoveryModification = enum {
    discovered,
    updated,
    no_change,

    pub const json_field_names = .{
        .discovered = "DISCOVERED",
        .updated = "UPDATED",
        .no_change = "NO_CHANGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .discovered => "DISCOVERED",
            .updated => "UPDATED",
            .no_change => "NO_CHANGE",
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

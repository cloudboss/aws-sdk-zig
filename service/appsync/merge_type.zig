const std = @import("std");

pub const MergeType = enum {
    manual_merge,
    auto_merge,

    pub const json_field_names = .{
        .manual_merge = "MANUAL_MERGE",
        .auto_merge = "AUTO_MERGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .manual_merge => "MANUAL_MERGE",
            .auto_merge => "AUTO_MERGE",
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

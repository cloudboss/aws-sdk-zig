const std = @import("std");

pub const MergeOptionTypeEnum = enum {
    fast_forward_merge,
    squash_merge,
    three_way_merge,

    pub const json_field_names = .{
        .fast_forward_merge = "FAST_FORWARD_MERGE",
        .squash_merge = "SQUASH_MERGE",
        .three_way_merge = "THREE_WAY_MERGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .fast_forward_merge => "FAST_FORWARD_MERGE",
            .squash_merge => "SQUASH_MERGE",
            .three_way_merge => "THREE_WAY_MERGE",
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

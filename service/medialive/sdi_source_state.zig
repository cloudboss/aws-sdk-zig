const std = @import("std");

/// Used in SdiSource, DescribeNodeRequest, DescribeNodeResult
pub const SdiSourceState = enum {
    idle,
    in_use,
    deleted,

    pub const json_field_names = .{
        .idle = "IDLE",
        .in_use = "IN_USE",
        .deleted = "DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .idle => "IDLE",
            .in_use => "IN_USE",
            .deleted => "DELETED",
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

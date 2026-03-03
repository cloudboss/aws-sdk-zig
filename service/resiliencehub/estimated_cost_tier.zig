const std = @import("std");

pub const EstimatedCostTier = enum {
    l1,
    l2,
    l3,
    l4,

    pub const json_field_names = .{
        .l1 = "L1",
        .l2 = "L2",
        .l3 = "L3",
        .l4 = "L4",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .l1 => "L1",
            .l2 => "L2",
            .l3 => "L3",
            .l4 => "L4",
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

const std = @import("std");

pub const TierName = enum {
    essential,
    growth,
    accelerate,
    premier,

    pub const json_field_names = .{
        .essential = "Essential",
        .growth = "Growth",
        .accelerate = "Accelerate",
        .premier = "Premier",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .essential => "Essential",
            .growth => "Growth",
            .accelerate => "Accelerate",
            .premier => "Premier",
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

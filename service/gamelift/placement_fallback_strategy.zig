const std = @import("std");

pub const PlacementFallbackStrategy = enum {
    default_after_single_pass,
    none,

    pub const json_field_names = .{
        .default_after_single_pass = "DEFAULT_AFTER_SINGLE_PASS",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default_after_single_pass => "DEFAULT_AFTER_SINGLE_PASS",
            .none => "NONE",
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

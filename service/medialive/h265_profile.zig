const std = @import("std");

/// H265 Profile
pub const H265Profile = enum {
    main,
    main_10_bit,

    pub const json_field_names = .{
        .main = "MAIN",
        .main_10_bit = "MAIN_10BIT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .main => "MAIN",
            .main_10_bit => "MAIN_10BIT",
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

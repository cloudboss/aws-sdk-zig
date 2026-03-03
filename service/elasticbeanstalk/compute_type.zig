const std = @import("std");

pub const ComputeType = enum {
    build_general1_small,
    build_general1_medium,
    build_general1_large,

    pub const json_field_names = .{
        .build_general1_small = "BUILD_GENERAL1_SMALL",
        .build_general1_medium = "BUILD_GENERAL1_MEDIUM",
        .build_general1_large = "BUILD_GENERAL1_LARGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .build_general1_small => "BUILD_GENERAL1_SMALL",
            .build_general1_medium => "BUILD_GENERAL1_MEDIUM",
            .build_general1_large => "BUILD_GENERAL1_LARGE",
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

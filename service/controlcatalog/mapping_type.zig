const std = @import("std");

pub const MappingType = enum {
    framework,
    common_control,
    related_control,

    pub const json_field_names = .{
        .framework = "FRAMEWORK",
        .common_control = "COMMON_CONTROL",
        .related_control = "RELATED_CONTROL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .framework => "FRAMEWORK",
            .common_control => "COMMON_CONTROL",
            .related_control => "RELATED_CONTROL",
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

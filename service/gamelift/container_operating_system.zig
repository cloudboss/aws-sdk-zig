const std = @import("std");

pub const ContainerOperatingSystem = enum {
    amazon_linux_2023,

    pub const json_field_names = .{
        .amazon_linux_2023 = "AMAZON_LINUX_2023",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .amazon_linux_2023 => "AMAZON_LINUX_2023",
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

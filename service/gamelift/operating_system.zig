const std = @import("std");

pub const OperatingSystem = enum {
    windows_2012,
    amazon_linux,
    amazon_linux_2,
    windows_2016,
    amazon_linux_2023,
    windows_2022,

    pub const json_field_names = .{
        .windows_2012 = "WINDOWS_2012",
        .amazon_linux = "AMAZON_LINUX",
        .amazon_linux_2 = "AMAZON_LINUX_2",
        .windows_2016 = "WINDOWS_2016",
        .amazon_linux_2023 = "AMAZON_LINUX_2023",
        .windows_2022 = "WINDOWS_2022",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .windows_2012 => "WINDOWS_2012",
            .amazon_linux => "AMAZON_LINUX",
            .amazon_linux_2 => "AMAZON_LINUX_2",
            .windows_2016 => "WINDOWS_2016",
            .amazon_linux_2023 => "AMAZON_LINUX_2023",
            .windows_2022 => "WINDOWS_2022",
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

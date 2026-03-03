const std = @import("std");

pub const ServerOsType = enum {
    windows_server,
    amazon_linux,
    end_of_support_windows_server,
    redhat,
    other,

    pub const json_field_names = .{
        .windows_server = "WindowsServer",
        .amazon_linux = "AmazonLinux",
        .end_of_support_windows_server = "EndOfSupportWindowsServer",
        .redhat = "Redhat",
        .other = "Other",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .windows_server => "WindowsServer",
            .amazon_linux => "AmazonLinux",
            .end_of_support_windows_server => "EndOfSupportWindowsServer",
            .redhat => "Redhat",
            .other => "Other",
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

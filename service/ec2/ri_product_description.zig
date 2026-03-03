const std = @import("std");

pub const RIProductDescription = enum {
    linux_unix,
    linux_unix_amazon_vpc_,
    windows,
    windows_amazon_vpc_,

    pub const json_field_names = .{
        .linux_unix = "Linux/UNIX",
        .linux_unix_amazon_vpc_ = "Linux/UNIX (Amazon VPC)",
        .windows = "Windows",
        .windows_amazon_vpc_ = "Windows (Amazon VPC)",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .linux_unix => "Linux/UNIX",
            .linux_unix_amazon_vpc_ => "Linux/UNIX (Amazon VPC)",
            .windows => "Windows",
            .windows_amazon_vpc_ => "Windows (Amazon VPC)",
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

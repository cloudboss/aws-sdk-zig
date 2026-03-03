const std = @import("std");

pub const NetworkInterfaceAttribute = enum {
    description,
    group_set,
    source_dest_check,
    attachment,
    associate_public_ip_address,

    pub const json_field_names = .{
        .description = "description",
        .group_set = "groupSet",
        .source_dest_check = "sourceDestCheck",
        .attachment = "attachment",
        .associate_public_ip_address = "associatePublicIpAddress",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .description => "description",
            .group_set => "groupSet",
            .source_dest_check => "sourceDestCheck",
            .attachment => "attachment",
            .associate_public_ip_address => "associatePublicIpAddress",
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

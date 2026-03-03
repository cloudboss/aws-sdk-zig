const std = @import("std");

pub const DependentServiceName = enum {
    aws_config,
    awswaf,
    aws_shield_advanced,
    aws_virtual_private_cloud,

    pub const json_field_names = .{
        .aws_config = "AWSCONFIG",
        .awswaf = "AWSWAF",
        .aws_shield_advanced = "AWSSHIELD_ADVANCED",
        .aws_virtual_private_cloud = "AWSVPC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_config => "AWSCONFIG",
            .awswaf => "AWSWAF",
            .aws_shield_advanced => "AWSSHIELD_ADVANCED",
            .aws_virtual_private_cloud => "AWSVPC",
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

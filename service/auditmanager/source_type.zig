const std = @import("std");

pub const SourceType = enum {
    aws_cloudtrail,
    aws_config,
    aws_security_hub,
    aws_api_call,
    manual,
    common_control,
    core_control,

    pub const json_field_names = .{
        .aws_cloudtrail = "AWS_Cloudtrail",
        .aws_config = "AWS_Config",
        .aws_security_hub = "AWS_Security_Hub",
        .aws_api_call = "AWS_API_Call",
        .manual = "MANUAL",
        .common_control = "Common_Control",
        .core_control = "Core_Control",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_cloudtrail => "AWS_Cloudtrail",
            .aws_config => "AWS_Config",
            .aws_security_hub => "AWS_Security_Hub",
            .aws_api_call => "AWS_API_Call",
            .manual => "MANUAL",
            .common_control => "Common_Control",
            .core_control => "Core_Control",
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

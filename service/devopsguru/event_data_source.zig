const std = @import("std");

pub const EventDataSource = enum {
    aws_cloud_trail,
    aws_code_deploy,

    pub const json_field_names = .{
        .aws_cloud_trail = "AWS_CLOUD_TRAIL",
        .aws_code_deploy = "AWS_CODE_DEPLOY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_cloud_trail => "AWS_CLOUD_TRAIL",
            .aws_code_deploy => "AWS_CODE_DEPLOY",
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

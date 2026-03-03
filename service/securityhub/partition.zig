const std = @import("std");

pub const Partition = enum {
    aws,
    aws_cn,
    aws_us_gov,

    pub const json_field_names = .{
        .aws = "aws",
        .aws_cn = "aws-cn",
        .aws_us_gov = "aws-us-gov",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws => "aws",
            .aws_cn => "aws-cn",
            .aws_us_gov => "aws-us-gov",
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

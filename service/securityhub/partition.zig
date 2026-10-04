const std = @import("std");

pub const Partition = enum {
    aws,
    aws_cn,
    aws_us_gov,
    aws_us_iso,
    aws_us_iso_b,
    azure_cloud,

    pub const json_field_names = .{
        .aws = "aws",
        .aws_cn = "aws-cn",
        .aws_us_gov = "aws-us-gov",
        .aws_us_iso = "aws-us-iso",
        .aws_us_iso_b = "aws-us-iso-b",
        .azure_cloud = "AzureCloud",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws => "aws",
            .aws_cn => "aws-cn",
            .aws_us_gov => "aws-us-gov",
            .aws_us_iso => "aws-us-iso",
            .aws_us_iso_b => "aws-us-iso-b",
            .azure_cloud => "AzureCloud",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};

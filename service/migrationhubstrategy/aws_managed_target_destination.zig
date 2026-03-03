const std = @import("std");

pub const AwsManagedTargetDestination = enum {
    none_specified,
    aws_elastic_beanstalk,
    aws_fargate,

    pub const json_field_names = .{
        .none_specified = "None specified",
        .aws_elastic_beanstalk = "AWS Elastic BeanStalk",
        .aws_fargate = "AWS Fargate",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none_specified => "None specified",
            .aws_elastic_beanstalk => "AWS Elastic BeanStalk",
            .aws_fargate => "AWS Fargate",
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

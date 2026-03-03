const std = @import("std");

pub const FreeTrialType = enum {
    ec2,
    ecr,
    lambda,
    lambda_code,
    code_repository,

    pub const json_field_names = .{
        .ec2 = "EC2",
        .ecr = "ECR",
        .lambda = "LAMBDA",
        .lambda_code = "LAMBDA_CODE",
        .code_repository = "CODE_REPOSITORY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ec2 => "EC2",
            .ecr => "ECR",
            .lambda => "LAMBDA",
            .lambda_code => "LAMBDA_CODE",
            .code_repository => "CODE_REPOSITORY",
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

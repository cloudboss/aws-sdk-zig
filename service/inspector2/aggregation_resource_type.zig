const std = @import("std");

pub const AggregationResourceType = enum {
    aws_ec2_instance,
    aws_ecr_container_image,
    aws_lambda_function,
    code_repository,

    pub const json_field_names = .{
        .aws_ec2_instance = "AWS_EC2_INSTANCE",
        .aws_ecr_container_image = "AWS_ECR_CONTAINER_IMAGE",
        .aws_lambda_function = "AWS_LAMBDA_FUNCTION",
        .code_repository = "CODE_REPOSITORY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_ec2_instance => "AWS_EC2_INSTANCE",
            .aws_ecr_container_image => "AWS_ECR_CONTAINER_IMAGE",
            .aws_lambda_function => "AWS_LAMBDA_FUNCTION",
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

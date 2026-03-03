const std = @import("std");

pub const AggregationType = enum {
    finding_type,
    package,
    title,
    repository,
    ami,
    aws_ec2_instance,
    aws_ecr_container,
    image_layer,
    account,
    aws_lambda_function,
    lambda_layer,
    code_repository,

    pub const json_field_names = .{
        .finding_type = "FINDING_TYPE",
        .package = "PACKAGE",
        .title = "TITLE",
        .repository = "REPOSITORY",
        .ami = "AMI",
        .aws_ec2_instance = "AWS_EC2_INSTANCE",
        .aws_ecr_container = "AWS_ECR_CONTAINER",
        .image_layer = "IMAGE_LAYER",
        .account = "ACCOUNT",
        .aws_lambda_function = "AWS_LAMBDA_FUNCTION",
        .lambda_layer = "LAMBDA_LAYER",
        .code_repository = "CODE_REPOSITORY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .finding_type => "FINDING_TYPE",
            .package => "PACKAGE",
            .title => "TITLE",
            .repository => "REPOSITORY",
            .ami => "AMI",
            .aws_ec2_instance => "AWS_EC2_INSTANCE",
            .aws_ecr_container => "AWS_ECR_CONTAINER",
            .image_layer => "IMAGE_LAYER",
            .account => "ACCOUNT",
            .aws_lambda_function => "AWS_LAMBDA_FUNCTION",
            .lambda_layer => "LAMBDA_LAYER",
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

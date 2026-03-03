const std = @import("std");

pub const ValidatePolicyResourceType = enum {
    s3_bucket,
    s3_access_point,
    s3_multi_region_access_point,
    s3_object_lambda_access_point,
    role_trust,
    dynamodb_table,

    pub const json_field_names = .{
        .s3_bucket = "AWS::S3::Bucket",
        .s3_access_point = "AWS::S3::AccessPoint",
        .s3_multi_region_access_point = "AWS::S3::MultiRegionAccessPoint",
        .s3_object_lambda_access_point = "AWS::S3ObjectLambda::AccessPoint",
        .role_trust = "AWS::IAM::AssumeRolePolicyDocument",
        .dynamodb_table = "AWS::DynamoDB::Table",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .s3_bucket => "AWS::S3::Bucket",
            .s3_access_point => "AWS::S3::AccessPoint",
            .s3_multi_region_access_point => "AWS::S3::MultiRegionAccessPoint",
            .s3_object_lambda_access_point => "AWS::S3ObjectLambda::AccessPoint",
            .role_trust => "AWS::IAM::AssumeRolePolicyDocument",
            .dynamodb_table => "AWS::DynamoDB::Table",
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

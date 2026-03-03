const std = @import("std");

pub const ResourceType = enum {
    aws_s3_bucket,
    aws_iam_role,
    aws_sqs_queue,
    aws_lambda_function,
    aws_lambda_layerversion,
    aws_kms_key,
    aws_secretsmanager_secret,
    aws_efs_filesystem,
    aws_ec2_snapshot,
    aws_ecr_repository,
    aws_rds_dbsnapshot,
    aws_rds_dbclustersnapshot,
    aws_sns_topic,
    aws_s3_express_directorybucket,
    aws_dynamodb_table,
    aws_dynamodb_stream,
    aws_iam_user,

    pub const json_field_names = .{
        .aws_s3_bucket = "AWS::S3::Bucket",
        .aws_iam_role = "AWS::IAM::Role",
        .aws_sqs_queue = "AWS::SQS::Queue",
        .aws_lambda_function = "AWS::Lambda::Function",
        .aws_lambda_layerversion = "AWS::Lambda::LayerVersion",
        .aws_kms_key = "AWS::KMS::Key",
        .aws_secretsmanager_secret = "AWS::SecretsManager::Secret",
        .aws_efs_filesystem = "AWS::EFS::FileSystem",
        .aws_ec2_snapshot = "AWS::EC2::Snapshot",
        .aws_ecr_repository = "AWS::ECR::Repository",
        .aws_rds_dbsnapshot = "AWS::RDS::DBSnapshot",
        .aws_rds_dbclustersnapshot = "AWS::RDS::DBClusterSnapshot",
        .aws_sns_topic = "AWS::SNS::Topic",
        .aws_s3_express_directorybucket = "AWS::S3Express::DirectoryBucket",
        .aws_dynamodb_table = "AWS::DynamoDB::Table",
        .aws_dynamodb_stream = "AWS::DynamoDB::Stream",
        .aws_iam_user = "AWS::IAM::User",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_s3_bucket => "AWS::S3::Bucket",
            .aws_iam_role => "AWS::IAM::Role",
            .aws_sqs_queue => "AWS::SQS::Queue",
            .aws_lambda_function => "AWS::Lambda::Function",
            .aws_lambda_layerversion => "AWS::Lambda::LayerVersion",
            .aws_kms_key => "AWS::KMS::Key",
            .aws_secretsmanager_secret => "AWS::SecretsManager::Secret",
            .aws_efs_filesystem => "AWS::EFS::FileSystem",
            .aws_ec2_snapshot => "AWS::EC2::Snapshot",
            .aws_ecr_repository => "AWS::ECR::Repository",
            .aws_rds_dbsnapshot => "AWS::RDS::DBSnapshot",
            .aws_rds_dbclustersnapshot => "AWS::RDS::DBClusterSnapshot",
            .aws_sns_topic => "AWS::SNS::Topic",
            .aws_s3_express_directorybucket => "AWS::S3Express::DirectoryBucket",
            .aws_dynamodb_table => "AWS::DynamoDB::Table",
            .aws_dynamodb_stream => "AWS::DynamoDB::Stream",
            .aws_iam_user => "AWS::IAM::User",
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

const std = @import("std");

pub const AccessCheckResourceType = enum {
    dynamodb_table,
    dynamodb_stream,
    efs_filesystem,
    opensearchservice_domain,
    kinesis_data_stream,
    kinesis_stream_consumer,
    kms_key,
    lambda_function,
    s3_bucket,
    s3_access_point,
    s3_express_directorybucket,
    s3_glacier,
    s3_outposts_bucket,
    s3_outposts_access_point,
    secretsmanager_secret,
    sns_topic,
    sqs_queue,
    role_trust,
    s3_table_bucket,
    api_gateway_rest_api,
    code_artifact_domain,
    backup_vault,
    cloudtrail_dashboard,
    cloudtrail_event_data_store,
    s3_table,
    s3_express_access_point,

    pub const json_field_names = .{
        .dynamodb_table = "AWS::DynamoDB::Table",
        .dynamodb_stream = "AWS::DynamoDB::Stream",
        .efs_filesystem = "AWS::EFS::FileSystem",
        .opensearchservice_domain = "AWS::OpenSearchService::Domain",
        .kinesis_data_stream = "AWS::Kinesis::Stream",
        .kinesis_stream_consumer = "AWS::Kinesis::StreamConsumer",
        .kms_key = "AWS::KMS::Key",
        .lambda_function = "AWS::Lambda::Function",
        .s3_bucket = "AWS::S3::Bucket",
        .s3_access_point = "AWS::S3::AccessPoint",
        .s3_express_directorybucket = "AWS::S3Express::DirectoryBucket",
        .s3_glacier = "AWS::S3::Glacier",
        .s3_outposts_bucket = "AWS::S3Outposts::Bucket",
        .s3_outposts_access_point = "AWS::S3Outposts::AccessPoint",
        .secretsmanager_secret = "AWS::SecretsManager::Secret",
        .sns_topic = "AWS::SNS::Topic",
        .sqs_queue = "AWS::SQS::Queue",
        .role_trust = "AWS::IAM::AssumeRolePolicyDocument",
        .s3_table_bucket = "AWS::S3Tables::TableBucket",
        .api_gateway_rest_api = "AWS::ApiGateway::RestApi",
        .code_artifact_domain = "AWS::CodeArtifact::Domain",
        .backup_vault = "AWS::Backup::BackupVault",
        .cloudtrail_dashboard = "AWS::CloudTrail::Dashboard",
        .cloudtrail_event_data_store = "AWS::CloudTrail::EventDataStore",
        .s3_table = "AWS::S3Tables::Table",
        .s3_express_access_point = "AWS::S3Express::AccessPoint",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .dynamodb_table => "AWS::DynamoDB::Table",
            .dynamodb_stream => "AWS::DynamoDB::Stream",
            .efs_filesystem => "AWS::EFS::FileSystem",
            .opensearchservice_domain => "AWS::OpenSearchService::Domain",
            .kinesis_data_stream => "AWS::Kinesis::Stream",
            .kinesis_stream_consumer => "AWS::Kinesis::StreamConsumer",
            .kms_key => "AWS::KMS::Key",
            .lambda_function => "AWS::Lambda::Function",
            .s3_bucket => "AWS::S3::Bucket",
            .s3_access_point => "AWS::S3::AccessPoint",
            .s3_express_directorybucket => "AWS::S3Express::DirectoryBucket",
            .s3_glacier => "AWS::S3::Glacier",
            .s3_outposts_bucket => "AWS::S3Outposts::Bucket",
            .s3_outposts_access_point => "AWS::S3Outposts::AccessPoint",
            .secretsmanager_secret => "AWS::SecretsManager::Secret",
            .sns_topic => "AWS::SNS::Topic",
            .sqs_queue => "AWS::SQS::Queue",
            .role_trust => "AWS::IAM::AssumeRolePolicyDocument",
            .s3_table_bucket => "AWS::S3Tables::TableBucket",
            .api_gateway_rest_api => "AWS::ApiGateway::RestApi",
            .code_artifact_domain => "AWS::CodeArtifact::Domain",
            .backup_vault => "AWS::Backup::BackupVault",
            .cloudtrail_dashboard => "AWS::CloudTrail::Dashboard",
            .cloudtrail_event_data_store => "AWS::CloudTrail::EventDataStore",
            .s3_table => "AWS::S3Tables::Table",
            .s3_express_access_point => "AWS::S3Express::AccessPoint",
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

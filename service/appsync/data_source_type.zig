const std = @import("std");

pub const DataSourceType = enum {
    aws_lambda,
    amazon_dynamodb,
    amazon_elasticsearch,
    none,
    http,
    relational_database,
    amazon_opensearch_service,
    amazon_eventbridge,
    amazon_bedrock_runtime,

    pub const json_field_names = .{
        .aws_lambda = "AWS_LAMBDA",
        .amazon_dynamodb = "AMAZON_DYNAMODB",
        .amazon_elasticsearch = "AMAZON_ELASTICSEARCH",
        .none = "NONE",
        .http = "HTTP",
        .relational_database = "RELATIONAL_DATABASE",
        .amazon_opensearch_service = "AMAZON_OPENSEARCH_SERVICE",
        .amazon_eventbridge = "AMAZON_EVENTBRIDGE",
        .amazon_bedrock_runtime = "AMAZON_BEDROCK_RUNTIME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_lambda => "AWS_LAMBDA",
            .amazon_dynamodb => "AMAZON_DYNAMODB",
            .amazon_elasticsearch => "AMAZON_ELASTICSEARCH",
            .none => "NONE",
            .http => "HTTP",
            .relational_database => "RELATIONAL_DATABASE",
            .amazon_opensearch_service => "AMAZON_OPENSEARCH_SERVICE",
            .amazon_eventbridge => "AMAZON_EVENTBRIDGE",
            .amazon_bedrock_runtime => "AMAZON_BEDROCK_RUNTIME",
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

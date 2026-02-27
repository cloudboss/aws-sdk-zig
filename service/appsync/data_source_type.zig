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
};

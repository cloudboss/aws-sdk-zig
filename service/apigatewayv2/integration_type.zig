/// Represents an API method integration type.
pub const IntegrationType = enum {
    aws,
    http,
    mock,
    http_proxy,
    aws_proxy,

    pub const json_field_names = .{
        .aws = "AWS",
        .http = "HTTP",
        .mock = "MOCK",
        .http_proxy = "HTTP_PROXY",
        .aws_proxy = "AWS_PROXY",
    };
};

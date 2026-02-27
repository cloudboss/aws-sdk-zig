/// The integration type. The valid value is `HTTP` for integrating an API
/// method with an HTTP backend; `AWS` with any Amazon Web Services service
/// endpoints; `MOCK` for testing without actually invoking the backend;
/// `HTTP_PROXY` for integrating with the HTTP proxy integration; `AWS_PROXY`
/// for integrating with the Lambda proxy integration.
pub const IntegrationType = enum {
    http,
    aws,
    mock,
    http_proxy,
    aws_proxy,

    pub const json_field_names = .{
        .http = "HTTP",
        .aws = "AWS",
        .mock = "MOCK",
        .http_proxy = "HTTP_PROXY",
        .aws_proxy = "AWS_PROXY",
    };
};

const aws = @import("aws");

const ConnectionType = @import("connection_type.zig").ConnectionType;
const ContentHandlingStrategy = @import("content_handling_strategy.zig").ContentHandlingStrategy;
const IntegrationType = @import("integration_type.zig").IntegrationType;
const PassthroughBehavior = @import("passthrough_behavior.zig").PassthroughBehavior;
const TlsConfig = @import("tls_config.zig").TlsConfig;

/// Represents an integration.
pub const Integration = struct {
    /// Specifies whether an integration is managed by API Gateway. If you created
    /// an API using using quick create, the resulting integration is managed by API
    /// Gateway. You can update a managed integration, but you can't delete it.
    api_gateway_managed: ?bool,

    /// The ID of the VPC link for a private integration. Supported only for HTTP
    /// APIs.
    connection_id: ?[]const u8,

    /// The type of the network connection to the integration endpoint. Specify
    /// INTERNET for connections through the public routable internet or VPC_LINK
    /// for private connections between API Gateway and resources in a VPC. The
    /// default value is INTERNET.
    connection_type: ?ConnectionType,

    /// Supported only for WebSocket APIs. Specifies how to handle response payload
    /// content type conversions. Supported values are CONVERT_TO_BINARY and
    /// CONVERT_TO_TEXT, with the following behaviors:
    ///
    /// CONVERT_TO_BINARY: Converts a response payload from a Base64-encoded string
    /// to the corresponding binary blob.
    ///
    /// CONVERT_TO_TEXT: Converts a response payload from a binary blob to a
    /// Base64-encoded string.
    ///
    /// If this property is not defined, the response payload will be passed through
    /// from the integration response to the route response or method response
    /// without modification.
    content_handling_strategy: ?ContentHandlingStrategy,

    /// Specifies the credentials required for the integration, if any. For AWS
    /// integrations, three options are available. To specify an IAM Role for API
    /// Gateway to assume, use the role's Amazon Resource Name (ARN). To require
    /// that the caller's identity be passed through from the request, specify the
    /// string arn:aws:iam::*:user/*. To use resource-based permissions on supported
    /// AWS services, specify null.
    credentials_arn: ?[]const u8,

    /// Represents the description of an integration.
    description: ?[]const u8,

    /// Represents the identifier of an integration.
    integration_id: ?[]const u8,

    /// Specifies the integration's HTTP method type.
    integration_method: ?[]const u8,

    /// The integration response selection expression for the integration. Supported
    /// only for WebSocket APIs. See [Integration Response Selection
    /// Expressions](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api-selection-expressions.html#apigateway-websocket-api-integration-response-selection-expressions).
    integration_response_selection_expression: ?[]const u8,

    /// Supported only for HTTP API AWS_PROXY integrations. Specifies the AWS
    /// service action to invoke. To learn more, see [Integration subtype
    /// reference](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-develop-integrations-aws-services-reference.html).
    integration_subtype: ?[]const u8,

    /// The integration type of an integration. One of the following:
    ///
    /// AWS: for integrating the route or method request with an AWS service action,
    /// including the Lambda function-invoking action. With the Lambda
    /// function-invoking action, this is referred to as the Lambda custom
    /// integration. With any other AWS service action, this is known as AWS
    /// integration. Supported only for WebSocket APIs.
    ///
    /// AWS_PROXY: for integrating the route or method request with a Lambda
    /// function or other AWS service action. This integration is also referred to
    /// as a Lambda proxy integration.
    ///
    /// HTTP: for integrating the route or method request with an HTTP endpoint.
    /// This integration is also referred to as the HTTP custom integration.
    /// Supported only for WebSocket APIs.
    ///
    /// HTTP_PROXY: for integrating the route or method request with an HTTP
    /// endpoint, with the client request passed through as-is. This is also
    /// referred to as HTTP proxy integration.
    ///
    /// MOCK: for integrating the route or method request with API Gateway as a
    /// "loopback" endpoint without invoking any backend. Supported only for
    /// WebSocket APIs.
    integration_type: ?IntegrationType,

    /// For a Lambda integration, specify the URI of a Lambda function.
    ///
    /// For an HTTP integration, specify a fully-qualified URL.
    ///
    /// For an HTTP API private integration, specify the ARN of an Application Load
    /// Balancer listener, Network Load Balancer listener, or AWS Cloud Map service.
    /// If you specify the ARN of an AWS Cloud Map service, API Gateway uses
    /// DiscoverInstances to identify resources. You can use query parameters to
    /// target specific resources. To learn more, see
    /// [DiscoverInstances](https://docs.aws.amazon.com/cloud-map/latest/api/API_DiscoverInstances.html). For private integrations, all resources must be owned by the same AWS account.
    integration_uri: ?[]const u8,

    /// Specifies the pass-through behavior for incoming requests based on the
    /// Content-Type header in the request, and the available mapping templates
    /// specified as the requestTemplates property on the Integration resource.
    /// There are three valid values: WHEN_NO_MATCH, WHEN_NO_TEMPLATES, and NEVER.
    /// Supported only for WebSocket APIs.
    ///
    /// WHEN_NO_MATCH passes the request body for unmapped content types through to
    /// the integration backend without transformation.
    ///
    /// NEVER rejects unmapped content types with an HTTP 415 Unsupported Media Type
    /// response.
    ///
    /// WHEN_NO_TEMPLATES allows pass-through when the integration has no content
    /// types mapped to templates. However, if there is at least one content type
    /// defined, unmapped content types will be rejected with the same HTTP 415
    /// Unsupported Media Type response.
    passthrough_behavior: ?PassthroughBehavior,

    /// Specifies the format of the payload sent to an integration. Required for
    /// HTTP APIs. Supported values for Lambda proxy integrations are 1.0 and 2.0.
    /// For all other integrations, 1.0 is the only supported value. To learn more,
    /// see [Working with AWS Lambda proxy integrations for HTTP
    /// APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-develop-integrations-lambda.html).
    payload_format_version: ?[]const u8,

    /// For WebSocket APIs, a key-value map specifying request parameters that are
    /// passed from the method request to the backend. The key is an integration
    /// request parameter name and the associated value is a method request
    /// parameter value or static value that must be enclosed within single quotes
    /// and pre-encoded as required by the backend. The method request parameter
    /// value must match the pattern of method.request.{location}.{name}
    /// , where
    /// {location}
    /// is querystring, path, or header; and
    /// {name}
    /// must be a valid and unique method request parameter name.
    ///
    /// For HTTP API integrations with a specified integrationSubtype, request
    /// parameters are a key-value map specifying parameters that are passed to
    /// AWS_PROXY integrations. You can provide static values, or map request data,
    /// stage variables, or context variables that are evaluated at runtime. To
    /// learn more, see [Working with AWS service integrations for HTTP
    /// APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-develop-integrations-aws-services.html).
    ///
    /// For HTTP API integrations, without a specified integrationSubtype request
    /// parameters are a key-value map specifying how to transform HTTP requests
    /// before sending them to backend integrations. The key should follow the
    /// pattern <action>:<header|querystring|path>.<location>. The action can be
    /// append, overwrite or remove. For values, you can provide static values, or
    /// map request data, stage variables, or context variables that are evaluated
    /// at runtime. To learn more, see [Transforming API requests and
    /// responses](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-parameter-mapping.html).
    request_parameters: ?[]const aws.map.StringMapEntry,

    /// Represents a map of Velocity templates that are applied on the request
    /// payload based on the value of the Content-Type header sent by the client.
    /// The content type value is the key in this map, and the template (as a
    /// String) is the value. Supported only for WebSocket APIs.
    request_templates: ?[]const aws.map.StringMapEntry,

    /// Supported only for HTTP APIs. You use response parameters to transform the
    /// HTTP response from a backend integration before returning the response to
    /// clients. Specify a key-value map from a selection key to response
    /// parameters. The selection key must be a valid HTTP status code within the
    /// range of 200-599. Response parameters are a key-value map. The key must
    /// match pattern <action>:<header>.<location> or overwrite.statuscode. The
    /// action can be append, overwrite or remove. The value can be a static value,
    /// or map to response data, stage variables, or context variables that are
    /// evaluated at runtime. To learn more, see [Transforming API requests and
    /// responses](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-parameter-mapping.html).
    response_parameters: ?[]const aws.map.MapEntry([]const aws.map.StringMapEntry),

    /// The template selection expression for the integration. Supported only for
    /// WebSocket APIs.
    template_selection_expression: ?[]const u8,

    /// Custom timeout between 50 and 29,000 milliseconds for WebSocket APIs and
    /// between 50 and 30,000 milliseconds for HTTP APIs. The default timeout is 29
    /// seconds for WebSocket APIs and 30 seconds for HTTP APIs.
    timeout_in_millis: ?i32,

    /// The TLS configuration for a private integration. If you specify a TLS
    /// configuration, private integration traffic uses the HTTPS protocol.
    /// Supported only for HTTP APIs.
    tls_config: ?TlsConfig,

    pub const json_field_names = .{
        .api_gateway_managed = "ApiGatewayManaged",
        .connection_id = "ConnectionId",
        .connection_type = "ConnectionType",
        .content_handling_strategy = "ContentHandlingStrategy",
        .credentials_arn = "CredentialsArn",
        .description = "Description",
        .integration_id = "IntegrationId",
        .integration_method = "IntegrationMethod",
        .integration_response_selection_expression = "IntegrationResponseSelectionExpression",
        .integration_subtype = "IntegrationSubtype",
        .integration_type = "IntegrationType",
        .integration_uri = "IntegrationUri",
        .passthrough_behavior = "PassthroughBehavior",
        .payload_format_version = "PayloadFormatVersion",
        .request_parameters = "RequestParameters",
        .request_templates = "RequestTemplates",
        .response_parameters = "ResponseParameters",
        .template_selection_expression = "TemplateSelectionExpression",
        .timeout_in_millis = "TimeoutInMillis",
        .tls_config = "TlsConfig",
    };
};

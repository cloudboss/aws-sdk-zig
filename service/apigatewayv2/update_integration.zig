const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ConnectionType = @import("connection_type.zig").ConnectionType;
const ContentHandlingStrategy = @import("content_handling_strategy.zig").ContentHandlingStrategy;
const IntegrationType = @import("integration_type.zig").IntegrationType;
const PassthroughBehavior = @import("passthrough_behavior.zig").PassthroughBehavior;
const TlsConfigInput = @import("tls_config_input.zig").TlsConfigInput;
const TlsConfig = @import("tls_config.zig").TlsConfig;

pub const UpdateIntegrationInput = struct {
    /// The API identifier.
    api_id: []const u8,

    /// The ID of the VPC link for a private integration. Supported only for HTTP
    /// APIs.
    connection_id: ?[]const u8 = null,

    /// The type of the network connection to the integration endpoint. Specify
    /// INTERNET for connections through the public routable internet or VPC_LINK
    /// for private connections between API Gateway and resources in a VPC. The
    /// default value is INTERNET.
    connection_type: ?ConnectionType = null,

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
    content_handling_strategy: ?ContentHandlingStrategy = null,

    /// Specifies the credentials required for the integration, if any. For AWS
    /// integrations, three options are available. To specify an IAM Role for API
    /// Gateway to assume, use the role's Amazon Resource Name (ARN). To require
    /// that the caller's identity be passed through from the request, specify the
    /// string arn:aws:iam::*:user/*. To use resource-based permissions on supported
    /// AWS services, specify null.
    credentials_arn: ?[]const u8 = null,

    /// The description of the integration
    description: ?[]const u8 = null,

    /// The integration ID.
    integration_id: []const u8,

    /// Specifies the integration's HTTP method type.
    integration_method: ?[]const u8 = null,

    /// Supported only for HTTP API AWS_PROXY integrations. Specifies the AWS
    /// service action to invoke. To learn more, see [Integration subtype
    /// reference](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-develop-integrations-aws-services-reference.html).
    integration_subtype: ?[]const u8 = null,

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
    /// referred to as HTTP proxy integration. For HTTP API private integrations,
    /// use an HTTP_PROXY integration.
    ///
    /// MOCK: for integrating the route or method request with API Gateway as a
    /// "loopback" endpoint without invoking any backend. Supported only for
    /// WebSocket APIs.
    integration_type: ?IntegrationType = null,

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
    integration_uri: ?[]const u8 = null,

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
    passthrough_behavior: ?PassthroughBehavior = null,

    /// Specifies the format of the payload sent to an integration. Required for
    /// HTTP APIs. Supported values for Lambda proxy integrations are 1.0 and 2.0.
    /// For all other integrations, 1.0 is the only supported value. To learn more,
    /// see [Working with AWS Lambda proxy integrations for HTTP
    /// APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-develop-integrations-lambda.html).
    payload_format_version: ?[]const u8 = null,

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
    /// before sending them to the backend. The key should follow the pattern
    /// <action>:<header|querystring|path>.<location> where action can be append,
    /// overwrite or remove. For values, you can provide static values, or map
    /// request data, stage variables, or context variables that are evaluated at
    /// runtime. To learn more, see [Transforming API requests and
    /// responses](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-parameter-mapping.html).
    request_parameters: ?[]const aws.map.StringMapEntry = null,

    /// Represents a map of Velocity templates that are applied on the request
    /// payload based on the value of the Content-Type header sent by the client.
    /// The content type value is the key in this map, and the template (as a
    /// String) is the value. Supported only for WebSocket APIs.
    request_templates: ?[]const aws.map.StringMapEntry = null,

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
    response_parameters: ?[]const aws.map.MapEntry([]const aws.map.StringMapEntry) = null,

    /// The template selection expression for the integration.
    template_selection_expression: ?[]const u8 = null,

    /// Custom timeout between 50 and 29,000 milliseconds for WebSocket APIs and
    /// between 50 and 30,000 milliseconds for HTTP APIs. The default timeout is 29
    /// seconds for WebSocket APIs and 30 seconds for HTTP APIs.
    timeout_in_millis: ?i32 = null,

    /// The TLS configuration for a private integration. If you specify a TLS
    /// configuration, private integration traffic uses the HTTPS protocol.
    /// Supported only for HTTP APIs.
    tls_config: ?TlsConfigInput = null,

    pub const json_field_names = .{
        .api_id = "ApiId",
        .connection_id = "ConnectionId",
        .connection_type = "ConnectionType",
        .content_handling_strategy = "ContentHandlingStrategy",
        .credentials_arn = "CredentialsArn",
        .description = "Description",
        .integration_id = "IntegrationId",
        .integration_method = "IntegrationMethod",
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

pub const UpdateIntegrationOutput = struct {
    /// Specifies whether an integration is managed by API Gateway. If you created
    /// an API using using quick create, the resulting integration is managed by API
    /// Gateway. You can update a managed integration, but you can't delete it.
    api_gateway_managed: ?bool = null,

    /// The ID of the VPC link for a private integration. Supported only for HTTP
    /// APIs.
    connection_id: ?[]const u8 = null,

    /// The type of the network connection to the integration endpoint. Specify
    /// INTERNET for connections through the public routable internet or VPC_LINK
    /// for private connections between API Gateway and resources in a VPC. The
    /// default value is INTERNET.
    connection_type: ?ConnectionType = null,

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
    content_handling_strategy: ?ContentHandlingStrategy = null,

    /// Specifies the credentials required for the integration, if any. For AWS
    /// integrations, three options are available. To specify an IAM Role for API
    /// Gateway to assume, use the role's Amazon Resource Name (ARN). To require
    /// that the caller's identity be passed through from the request, specify the
    /// string arn:aws:iam::*:user/*. To use resource-based permissions on supported
    /// AWS services, specify null.
    credentials_arn: ?[]const u8 = null,

    /// Represents the description of an integration.
    description: ?[]const u8 = null,

    /// Represents the identifier of an integration.
    integration_id: ?[]const u8 = null,

    /// Specifies the integration's HTTP method type.
    integration_method: ?[]const u8 = null,

    /// The integration response selection expression for the integration. Supported
    /// only for WebSocket APIs. See [Integration Response Selection
    /// Expressions](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api-selection-expressions.html#apigateway-websocket-api-integration-response-selection-expressions).
    integration_response_selection_expression: ?[]const u8 = null,

    /// Supported only for HTTP API AWS_PROXY integrations. Specifies the AWS
    /// service action to invoke. To learn more, see [Integration subtype
    /// reference](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-develop-integrations-aws-services-reference.html).
    integration_subtype: ?[]const u8 = null,

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
    integration_type: ?IntegrationType = null,

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
    integration_uri: ?[]const u8 = null,

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
    passthrough_behavior: ?PassthroughBehavior = null,

    /// Specifies the format of the payload sent to an integration. Required for
    /// HTTP APIs. Supported values for Lambda proxy integrations are 1.0 and 2.0.
    /// For all other integrations, 1.0 is the only supported value. To learn more,
    /// see [Working with AWS Lambda proxy integrations for HTTP
    /// APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-develop-integrations-lambda.html).
    payload_format_version: ?[]const u8 = null,

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
    request_parameters: ?[]const aws.map.StringMapEntry = null,

    /// Represents a map of Velocity templates that are applied on the request
    /// payload based on the value of the Content-Type header sent by the client.
    /// The content type value is the key in this map, and the template (as a
    /// String) is the value. Supported only for WebSocket APIs.
    request_templates: ?[]const aws.map.StringMapEntry = null,

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
    response_parameters: ?[]const aws.map.MapEntry([]const aws.map.StringMapEntry) = null,

    /// The template selection expression for the integration. Supported only for
    /// WebSocket APIs.
    template_selection_expression: ?[]const u8 = null,

    /// Custom timeout between 50 and 29,000 milliseconds for WebSocket APIs and
    /// between 50 and 30,000 milliseconds for HTTP APIs. The default timeout is 29
    /// seconds for WebSocket APIs and 30 seconds for HTTP APIs.
    timeout_in_millis: ?i32 = null,

    /// The TLS configuration for a private integration. If you specify a TLS
    /// configuration, private integration traffic uses the HTTPS protocol.
    /// Supported only for HTTP APIs.
    tls_config: ?TlsConfig = null,

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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateIntegrationInput, options: Options) !UpdateIntegrationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "apigatewayv2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateIntegrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigatewayv2", "ApiGatewayV2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/v2/apis/");
    try path_buf.appendSlice(allocator, input.api_id);
    try path_buf.appendSlice(allocator, "/integrations/");
    try path_buf.appendSlice(allocator, input.integration_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.connection_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ConnectionId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.connection_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ConnectionType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.content_handling_strategy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ContentHandlingStrategy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.credentials_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CredentialsArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.integration_method) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IntegrationMethod\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.integration_subtype) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IntegrationSubtype\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.integration_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IntegrationType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.integration_uri) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IntegrationUri\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.passthrough_behavior) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PassthroughBehavior\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.payload_format_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PayloadFormatVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.request_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RequestParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.request_templates) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RequestTemplates\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.response_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ResponseParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.template_selection_expression) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TemplateSelectionExpression\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.timeout_in_millis) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TimeoutInMillis\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tls_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TlsConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PATCH;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateIntegrationOutput {
    var result: UpdateIntegrationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateIntegrationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}

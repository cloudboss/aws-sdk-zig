const aws = @import("aws");

const ConnectionType = @import("connection_type.zig").ConnectionType;
const ContentHandlingStrategy = @import("content_handling_strategy.zig").ContentHandlingStrategy;
const IntegrationResponse = @import("integration_response.zig").IntegrationResponse;
const ResponseTransferMode = @import("response_transfer_mode.zig").ResponseTransferMode;
const TlsConfig = @import("tls_config.zig").TlsConfig;
const IntegrationType = @import("integration_type.zig").IntegrationType;

/// Represents an `HTTP`, `HTTP_PROXY`, `AWS`, `AWS_PROXY`, or Mock integration.
pub const Integration = struct {
    /// A list of request parameters whose values API Gateway caches. To be valid
    /// values for `cacheKeyParameters`, these parameters must also be specified for
    /// Method `requestParameters`.
    cache_key_parameters: ?[]const []const u8,

    /// Specifies a group of related cached parameters. By default, API Gateway uses
    /// the resource ID as the `cacheNamespace`. You can specify the same
    /// `cacheNamespace` across resources to return the same cached data for
    /// requests to different resources.
    cache_namespace: ?[]const u8,

    /// The ID of the VpcLink used for the integration when
    /// `connectionType=VPC_LINK` and undefined, otherwise.
    connection_id: ?[]const u8,

    /// The type of the network connection to the integration endpoint. The valid
    /// value is `INTERNET` for connections through the public routable internet or
    /// `VPC_LINK` for private connections between API Gateway and a network load
    /// balancer in a VPC. The default value is `INTERNET`.
    connection_type: ?ConnectionType,

    /// Specifies how to handle request payload content type conversions. Supported
    /// values are `CONVERT_TO_BINARY` and `CONVERT_TO_TEXT`, with the following
    /// behaviors:
    ///
    /// If this property is not defined, the request payload will be passed through
    /// from the method request to integration request without modification,
    /// provided that the `passthroughBehavior` is configured to support payload
    /// pass-through.
    content_handling: ?ContentHandlingStrategy,

    /// Specifies the credentials required for the integration, if any. For AWS
    /// integrations, three options are available. To specify an IAM Role for API
    /// Gateway to assume, use the role's Amazon Resource Name (ARN). To require
    /// that the caller's identity be passed through from the request, specify the
    /// string `arn:aws:iam::\*:user/\*`. To use resource-based permissions on
    /// supported Amazon Web Services services, specify null.
    credentials: ?[]const u8,

    /// Specifies the integration's HTTP method type. For the Type property, if you
    /// specify `MOCK`, this property is optional. For Lambda integrations, you must
    /// set the integration method to `POST`. For all other types, you must specify
    /// this property.
    http_method: ?[]const u8,

    /// Specifies the integration's responses.
    integration_responses: ?[]const aws.map.MapEntry(IntegrationResponse),

    /// The ALB or NLB listener to send the request to.
    integration_target: ?[]const u8,

    /// Specifies how the method request body of an unmapped content type will be
    /// passed through
    /// the integration request to the back end without transformation. A content
    /// type is unmapped if
    /// no mapping template is defined in the integration or the content type does
    /// not match any of
    /// the mapped content types, as specified in `requestTemplates`. The valid
    /// value is one of the
    /// following: `WHEN_NO_MATCH`: passes the method request body through the
    /// integration request to
    /// the back end without transformation when the method request content type
    /// does not match any
    /// content type associated with the mapping templates defined in the
    /// integration request.
    /// `WHEN_NO_TEMPLATES`: passes the method request body through the integration
    /// request to the back
    /// end without transformation when no mapping template is defined in the
    /// integration request. If
    /// a template is defined when this option is selected, the method request of an
    /// unmapped
    /// content-type will be rejected with an HTTP 415 Unsupported Media Type
    /// response. `NEVER`: rejects
    /// the method request with an HTTP 415 Unsupported Media Type response when
    /// either the method
    /// request content type does not match any content type associated with the
    /// mapping templates
    /// defined in the integration request or no mapping template is defined in the
    /// integration
    /// request.
    passthrough_behavior: ?[]const u8,

    /// A key-value map specifying request parameters that are passed from the
    /// method request to the back end. The key is an integration request parameter
    /// name and the associated value is a method request parameter value or static
    /// value that must be enclosed within single quotes and pre-encoded as required
    /// by the back end. The method request parameter value must match the pattern
    /// of `method.request.{location}.{name}`, where `location` is `querystring`,
    /// `path`, or `header` and `name` must be a valid and unique method request
    /// parameter name.
    request_parameters: ?[]const aws.map.StringMapEntry,

    /// Represents a map of Velocity templates that are applied on the request
    /// payload based on the value of the Content-Type header sent by the client.
    /// The content type value is the key in this map, and the template (as a
    /// String) is the value.
    request_templates: ?[]const aws.map.StringMapEntry,

    /// The response transfer mode of the integration.
    response_transfer_mode: ?ResponseTransferMode,

    /// Custom timeout between 50 and 29,000 milliseconds. The default value is
    /// 29,000 milliseconds or 29 seconds. You can increase the default value to
    /// longer than 29 seconds for Regional or private APIs only.
    timeout_in_millis: i32 = 0,

    /// Specifies the TLS configuration for an integration.
    tls_config: ?TlsConfig,

    /// Specifies an API method integration type. The valid value is one of the
    /// following:
    ///
    /// For the HTTP and HTTP proxy integrations, each integration can specify a
    /// protocol (`http/https`), port and path. Standard 80 and 443 ports are
    /// supported as well as custom ports above 1024. An HTTP or HTTP proxy
    /// integration with a `connectionType` of `VPC_LINK` is referred to as a
    /// private integration and uses a VpcLink to connect API Gateway to a network
    /// load balancer of a VPC.
    type: ?IntegrationType,

    /// Specifies Uniform Resource Identifier (URI) of the integration endpoint.
    ///
    /// For `HTTP` or `HTTP_PROXY` integrations, the URI must be a fully formed,
    /// encoded HTTP(S) URL
    /// according to the RFC-3986 specification for standard integrations. If
    /// `connectionType` is `VPC_LINK` specify the Network Load Balancer DNS name.
    /// For `AWS` or `AWS_PROXY` integrations, the URI is of
    /// the form
    /// `arn:aws:apigateway:{region}:{subdomain.service|service}:path|action/{service_api}`.
    /// Here, {Region} is the API Gateway region (e.g., us-east-1); {service} is the
    /// name of the
    /// integrated Amazon Web Services service (e.g., s3); and {subdomain} is a
    /// designated subdomain supported by
    /// certain Amazon Web Services service for fast host-name lookup. action can be
    /// used for an Amazon Web Services service
    /// action-based API, using an Action={name}&{p1}={v1}&p2={v2}... query string.
    /// The ensuing
    /// {service_api} refers to a supported action {name} plus any required input
    /// parameters.
    /// Alternatively, path can be used for an Amazon Web Services service
    /// path-based API. The ensuing service_api
    /// refers to the path to an Amazon Web Services service resource, including the
    /// region of the integrated Amazon Web Services
    /// service, if applicable. For example, for integration with the S3 API of
    /// GetObject, the uri can
    /// be either
    /// `arn:aws:apigateway:us-west-2:s3:action/GetObject&Bucket={bucket}&Key={key}`
    /// or
    /// `arn:aws:apigateway:us-west-2:s3:path/{bucket}/{key}`
    uri: ?[]const u8,

    pub const json_field_names = .{
        .cache_key_parameters = "cacheKeyParameters",
        .cache_namespace = "cacheNamespace",
        .connection_id = "connectionId",
        .connection_type = "connectionType",
        .content_handling = "contentHandling",
        .credentials = "credentials",
        .http_method = "httpMethod",
        .integration_responses = "integrationResponses",
        .integration_target = "integrationTarget",
        .passthrough_behavior = "passthroughBehavior",
        .request_parameters = "requestParameters",
        .request_templates = "requestTemplates",
        .response_transfer_mode = "responseTransferMode",
        .timeout_in_millis = "timeoutInMillis",
        .tls_config = "tlsConfig",
        .type = "type",
        .uri = "uri",
    };
};

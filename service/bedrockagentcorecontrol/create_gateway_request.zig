const aws = @import("aws");

const AuthorizerConfiguration = @import("authorizer_configuration.zig").AuthorizerConfiguration;
const AuthorizerType = @import("authorizer_type.zig").AuthorizerType;
const ExceptionLevel = @import("exception_level.zig").ExceptionLevel;
const GatewayInterceptorConfiguration = @import("gateway_interceptor_configuration.zig").GatewayInterceptorConfiguration;
const GatewayPolicyEngineConfiguration = @import("gateway_policy_engine_configuration.zig").GatewayPolicyEngineConfiguration;
const GatewayProtocolConfiguration = @import("gateway_protocol_configuration.zig").GatewayProtocolConfiguration;
const GatewayProtocolType = @import("gateway_protocol_type.zig").GatewayProtocolType;

pub const CreateGatewayRequest = struct {
    /// The authorizer configuration for the gateway. Required if `authorizerType`
    /// is `CUSTOM_JWT`.
    authorizer_configuration: ?AuthorizerConfiguration,

    /// The type of authorizer to use for the gateway.
    ///
    /// * `CUSTOM_JWT` - Authorize with a bearer token.
    /// * `AWS_IAM` - Authorize with your Amazon Web Services IAM credentials.
    /// * `NONE` - No authorization
    authorizer_type: AuthorizerType,

    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If you don't specify this field, a value is randomly
    /// generated for you. If this token matches a previous request, the service
    /// ignores the request, but doesn't return an error. For more information, see
    /// [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8,

    /// The description of the gateway.
    description: ?[]const u8,

    /// The level of detail in error messages returned when invoking the gateway.
    ///
    /// * If the value is `DEBUG`, granular exception messages are returned to help
    ///   a user debug the gateway.
    /// * If the value is omitted, a generic error message is returned to the end
    ///   user.
    exception_level: ?ExceptionLevel,

    /// A list of configuration settings for a gateway interceptor. Gateway
    /// interceptors allow custom code to be invoked during gateway invocations.
    interceptor_configurations: ?[]const GatewayInterceptorConfiguration,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt data
    /// associated with the gateway.
    kms_key_arn: ?[]const u8,

    /// The name of the gateway. The name must be unique within your account.
    name: []const u8,

    /// The policy engine configuration for the gateway. A policy engine is a
    /// collection of policies that evaluates and authorizes agent tool calls. When
    /// associated with a gateway, the policy engine intercepts all agent requests
    /// and determines whether to allow or deny each action based on the defined
    /// policies.
    policy_engine_configuration: ?GatewayPolicyEngineConfiguration,

    /// The configuration settings for the protocol specified in the `protocolType`
    /// parameter.
    protocol_configuration: ?GatewayProtocolConfiguration,

    /// The protocol type for the gateway.
    protocol_type: GatewayProtocolType,

    /// The Amazon Resource Name (ARN) of the IAM role that provides permissions for
    /// the gateway to access Amazon Web Services services.
    role_arn: []const u8,

    /// A map of key-value pairs to associate with the gateway as metadata tags.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .authorizer_configuration = "authorizerConfiguration",
        .authorizer_type = "authorizerType",
        .client_token = "clientToken",
        .description = "description",
        .exception_level = "exceptionLevel",
        .interceptor_configurations = "interceptorConfigurations",
        .kms_key_arn = "kmsKeyArn",
        .name = "name",
        .policy_engine_configuration = "policyEngineConfiguration",
        .protocol_configuration = "protocolConfiguration",
        .protocol_type = "protocolType",
        .role_arn = "roleArn",
        .tags = "tags",
    };
};

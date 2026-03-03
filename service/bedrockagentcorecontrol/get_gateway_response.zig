const AuthorizerConfiguration = @import("authorizer_configuration.zig").AuthorizerConfiguration;
const AuthorizerType = @import("authorizer_type.zig").AuthorizerType;
const ExceptionLevel = @import("exception_level.zig").ExceptionLevel;
const GatewayInterceptorConfiguration = @import("gateway_interceptor_configuration.zig").GatewayInterceptorConfiguration;
const GatewayPolicyEngineConfiguration = @import("gateway_policy_engine_configuration.zig").GatewayPolicyEngineConfiguration;
const GatewayProtocolConfiguration = @import("gateway_protocol_configuration.zig").GatewayProtocolConfiguration;
const GatewayProtocolType = @import("gateway_protocol_type.zig").GatewayProtocolType;
const GatewayStatus = @import("gateway_status.zig").GatewayStatus;
const WorkloadIdentityDetails = @import("workload_identity_details.zig").WorkloadIdentityDetails;

pub const GetGatewayResponse = struct {
    /// The authorizer configuration for the gateway.
    authorizer_configuration: ?AuthorizerConfiguration = null,

    /// Authorizer type for the gateway.
    authorizer_type: AuthorizerType,

    /// The timestamp when the gateway was created.
    created_at: i64,

    /// The description of the gateway.
    description: ?[]const u8 = null,

    /// The level of detail in error messages returned when invoking the gateway.
    ///
    /// * If the value is `DEBUG`, granular exception messages are returned to help
    ///   a user debug the gateway.
    /// * If the value is omitted, a generic error message is returned to the end
    ///   user.
    exception_level: ?ExceptionLevel = null,

    /// The Amazon Resource Name (ARN) of the gateway.
    gateway_arn: []const u8,

    /// The unique identifier of the gateway.
    gateway_id: []const u8,

    /// An endpoint for invoking gateway.
    gateway_url: ?[]const u8 = null,

    /// The interceptors configured on the gateway.
    interceptor_configurations: ?[]const GatewayInterceptorConfiguration = null,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt the gateway.
    kms_key_arn: ?[]const u8 = null,

    /// The name of the gateway.
    name: []const u8,

    /// The policy engine configuration for the gateway.
    policy_engine_configuration: ?GatewayPolicyEngineConfiguration = null,

    protocol_configuration: ?GatewayProtocolConfiguration = null,

    /// Protocol applied to a gateway.
    protocol_type: GatewayProtocolType,

    /// The IAM role ARN that provides permissions for the gateway.
    role_arn: ?[]const u8 = null,

    /// The current status of the gateway.
    status: GatewayStatus,

    /// The reasons for the current status of the gateway.
    status_reasons: ?[]const []const u8 = null,

    /// The timestamp when the gateway was last updated.
    updated_at: i64,

    /// The workload identity details for the gateway.
    workload_identity_details: ?WorkloadIdentityDetails = null,

    pub const json_field_names = .{
        .authorizer_configuration = "authorizerConfiguration",
        .authorizer_type = "authorizerType",
        .created_at = "createdAt",
        .description = "description",
        .exception_level = "exceptionLevel",
        .gateway_arn = "gatewayArn",
        .gateway_id = "gatewayId",
        .gateway_url = "gatewayUrl",
        .interceptor_configurations = "interceptorConfigurations",
        .kms_key_arn = "kmsKeyArn",
        .name = "name",
        .policy_engine_configuration = "policyEngineConfiguration",
        .protocol_configuration = "protocolConfiguration",
        .protocol_type = "protocolType",
        .role_arn = "roleArn",
        .status = "status",
        .status_reasons = "statusReasons",
        .updated_at = "updatedAt",
        .workload_identity_details = "workloadIdentityDetails",
    };
};

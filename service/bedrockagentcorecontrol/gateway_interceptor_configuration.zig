const InterceptorInputConfiguration = @import("interceptor_input_configuration.zig").InterceptorInputConfiguration;
const GatewayInterceptionPoint = @import("gateway_interception_point.zig").GatewayInterceptionPoint;
const InterceptorConfiguration = @import("interceptor_configuration.zig").InterceptorConfiguration;

/// The configuration for an interceptor on a gateway. This structure defines
/// settings for an interceptor that will be invoked during the invocation of
/// the gateway.
pub const GatewayInterceptorConfiguration = struct {
    /// The configuration for the input of the interceptor. This field specifies how
    /// the input to the interceptor is constructed
    input_configuration: ?InterceptorInputConfiguration = null,

    /// The supported points of interception. This field specifies which points
    /// during the gateway invocation to invoke the interceptor
    interception_points: []const GatewayInterceptionPoint,

    /// The infrastructure settings of an interceptor configuration. This structure
    /// defines how the interceptor can be invoked.
    interceptor: InterceptorConfiguration,

    pub const json_field_names = .{
        .input_configuration = "inputConfiguration",
        .interception_points = "interceptionPoints",
        .interceptor = "interceptor",
    };
};

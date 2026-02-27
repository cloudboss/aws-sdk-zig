const FailoverRouterInputProtocolConfiguration = @import("failover_router_input_protocol_configuration.zig").FailoverRouterInputProtocolConfiguration;
const FailoverInputSourcePriorityMode = @import("failover_input_source_priority_mode.zig").FailoverInputSourcePriorityMode;

/// Configuration settings for a failover router input that allows switching
/// between two input sources.
pub const FailoverRouterInputConfiguration = struct {
    /// The ARN of the network interface to use for this failover router input.
    network_interface_arn: []const u8,

    /// The index (0 or 1) that specifies which source in the protocol
    /// configurations list is currently active. Used to control which of the two
    /// failover sources is currently selected. This field is ignored when
    /// sourcePriorityMode is set to NO_PRIORITY
    primary_source_index: ?i32,

    /// A list of exactly two protocol configurations for the failover input
    /// sources. Both must use the same protocol type.
    protocol_configurations: []const FailoverRouterInputProtocolConfiguration,

    /// The mode for determining source priority in failover configurations.
    source_priority_mode: FailoverInputSourcePriorityMode,

    pub const json_field_names = .{
        .network_interface_arn = "NetworkInterfaceArn",
        .primary_source_index = "PrimarySourceIndex",
        .protocol_configurations = "ProtocolConfigurations",
        .source_priority_mode = "SourcePriorityMode",
    };
};

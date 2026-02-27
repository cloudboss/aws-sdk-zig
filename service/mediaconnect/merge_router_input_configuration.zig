const MergeRouterInputProtocolConfiguration = @import("merge_router_input_protocol_configuration.zig").MergeRouterInputProtocolConfiguration;

/// Configuration settings for a merge router input that combines two input
/// sources.
pub const MergeRouterInputConfiguration = struct {
    /// The time window in milliseconds for merging the two input sources.
    merge_recovery_window_milliseconds: i64,

    /// The ARN of the network interface to use for this merge router input.
    network_interface_arn: []const u8,

    /// A list of exactly two protocol configurations for the merge input sources.
    /// Both must use the same protocol type.
    protocol_configurations: []const MergeRouterInputProtocolConfiguration,

    pub const json_field_names = .{
        .merge_recovery_window_milliseconds = "MergeRecoveryWindowMilliseconds",
        .network_interface_arn = "NetworkInterfaceArn",
        .protocol_configurations = "ProtocolConfigurations",
    };
};

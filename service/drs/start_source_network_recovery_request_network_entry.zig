/// An object representing the Source Network to recover.
pub const StartSourceNetworkRecoveryRequestNetworkEntry = struct {
    /// CloudFormation stack name to be used for recovering the network.
    cfn_stack_name: ?[]const u8 = null,

    /// The ID of the Source Network you want to recover.
    source_network_id: []const u8,

    pub const json_field_names = .{
        .cfn_stack_name = "cfnStackName",
        .source_network_id = "sourceNetworkID",
    };
};

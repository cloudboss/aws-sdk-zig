/// Properties of Source Network related to a job event.
pub const SourceNetworkData = struct {
    /// Source Network ID.
    source_network_id: ?[]const u8,

    /// VPC ID protected by the Source Network.
    source_vpc: ?[]const u8,

    /// CloudFormation stack name that was deployed for recovering the Source
    /// Network.
    stack_name: ?[]const u8,

    /// ID of the recovered VPC following Source Network recovery.
    target_vpc: ?[]const u8,

    pub const json_field_names = .{
        .source_network_id = "sourceNetworkID",
        .source_vpc = "sourceVpc",
        .stack_name = "stackName",
        .target_vpc = "targetVpc",
    };
};

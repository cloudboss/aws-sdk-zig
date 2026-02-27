/// Item in a list of `DataflowEndpoint` groups.
pub const DataflowEndpointListItem = struct {
    /// ARN of a dataflow endpoint group.
    dataflow_endpoint_group_arn: ?[]const u8,

    /// UUID of a dataflow endpoint group.
    dataflow_endpoint_group_id: ?[]const u8,

    pub const json_field_names = .{
        .dataflow_endpoint_group_arn = "dataflowEndpointGroupArn",
        .dataflow_endpoint_group_id = "dataflowEndpointGroupId",
    };
};

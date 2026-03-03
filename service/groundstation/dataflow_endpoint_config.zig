/// Information about the dataflow endpoint `Config`.
pub const DataflowEndpointConfig = struct {
    /// Name of a dataflow endpoint.
    dataflow_endpoint_name: []const u8,

    /// Region of a dataflow endpoint.
    dataflow_endpoint_region: ?[]const u8 = null,

    pub const json_field_names = .{
        .dataflow_endpoint_name = "dataflowEndpointName",
        .dataflow_endpoint_region = "dataflowEndpointRegion",
    };
};

const DownlinkDataflowDetails = @import("downlink_dataflow_details.zig").DownlinkDataflowDetails;

/// Definition for a downlink agent endpoint
pub const DownlinkAwsGroundStationAgentEndpoint = struct {
    /// Dataflow details for the downlink endpoint
    dataflow_details: DownlinkDataflowDetails,

    /// Downlink dataflow endpoint name
    name: []const u8,

    pub const json_field_names = .{
        .dataflow_details = "dataflowDetails",
        .name = "name",
    };
};

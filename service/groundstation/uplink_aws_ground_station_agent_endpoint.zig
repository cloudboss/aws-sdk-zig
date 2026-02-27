const UplinkDataflowDetails = @import("uplink_dataflow_details.zig").UplinkDataflowDetails;

/// Definition for an uplink agent endpoint
pub const UplinkAwsGroundStationAgentEndpoint = struct {
    /// Dataflow details for the uplink endpoint
    dataflow_details: UplinkDataflowDetails,

    /// Uplink dataflow endpoint name
    name: []const u8,

    pub const json_field_names = .{
        .dataflow_details = "dataflowDetails",
        .name = "name",
    };
};

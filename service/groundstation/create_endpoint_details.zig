const DownlinkAwsGroundStationAgentEndpoint = @import("downlink_aws_ground_station_agent_endpoint.zig").DownlinkAwsGroundStationAgentEndpoint;
const UplinkAwsGroundStationAgentEndpoint = @import("uplink_aws_ground_station_agent_endpoint.zig").UplinkAwsGroundStationAgentEndpoint;

/// Endpoint definition used for creating a dataflow endpoint
pub const CreateEndpointDetails = union(enum) {
    /// Definition for a downlink agent endpoint
    downlink_aws_ground_station_agent_endpoint: ?DownlinkAwsGroundStationAgentEndpoint,
    /// Definition for an uplink agent endpoint
    uplink_aws_ground_station_agent_endpoint: ?UplinkAwsGroundStationAgentEndpoint,

    pub const json_field_names = .{
        .downlink_aws_ground_station_agent_endpoint = "downlinkAwsGroundStationAgentEndpoint",
        .uplink_aws_ground_station_agent_endpoint = "uplinkAwsGroundStationAgentEndpoint",
    };
};

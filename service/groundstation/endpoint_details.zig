const AwsGroundStationAgentEndpoint = @import("aws_ground_station_agent_endpoint.zig").AwsGroundStationAgentEndpoint;
const DownlinkAwsGroundStationAgentEndpointDetails = @import("downlink_aws_ground_station_agent_endpoint_details.zig").DownlinkAwsGroundStationAgentEndpointDetails;
const DataflowEndpoint = @import("dataflow_endpoint.zig").DataflowEndpoint;
const CapabilityHealthReason = @import("capability_health_reason.zig").CapabilityHealthReason;
const CapabilityHealth = @import("capability_health.zig").CapabilityHealth;
const SecurityDetails = @import("security_details.zig").SecurityDetails;
const UplinkAwsGroundStationAgentEndpointDetails = @import("uplink_aws_ground_station_agent_endpoint_details.zig").UplinkAwsGroundStationAgentEndpointDetails;

/// Information about the endpoint details.
pub const EndpointDetails = struct {
    /// An agent endpoint.
    aws_ground_station_agent_endpoint: ?AwsGroundStationAgentEndpoint,

    /// Definition for a downlink agent endpoint
    downlink_aws_ground_station_agent_endpoint: ?DownlinkAwsGroundStationAgentEndpointDetails,

    /// A dataflow endpoint.
    endpoint: ?DataflowEndpoint,

    /// Health reasons for a dataflow endpoint. This field is ignored when calling
    /// `CreateDataflowEndpointGroup`.
    health_reasons: ?[]const CapabilityHealthReason,

    /// A dataflow endpoint health status. This field is ignored when calling
    /// `CreateDataflowEndpointGroup`.
    health_status: ?CapabilityHealth,

    /// Endpoint security details including a list of subnets, a list of security
    /// groups and a role to connect streams to instances.
    security_details: ?SecurityDetails,

    /// Definition for an uplink agent endpoint
    uplink_aws_ground_station_agent_endpoint: ?UplinkAwsGroundStationAgentEndpointDetails,

    pub const json_field_names = .{
        .aws_ground_station_agent_endpoint = "awsGroundStationAgentEndpoint",
        .downlink_aws_ground_station_agent_endpoint = "downlinkAwsGroundStationAgentEndpoint",
        .endpoint = "endpoint",
        .health_reasons = "healthReasons",
        .health_status = "healthStatus",
        .security_details = "securityDetails",
        .uplink_aws_ground_station_agent_endpoint = "uplinkAwsGroundStationAgentEndpoint",
    };
};

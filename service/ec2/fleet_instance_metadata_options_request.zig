const FleetInstanceMetadataEndpointState = @import("fleet_instance_metadata_endpoint_state.zig").FleetInstanceMetadataEndpointState;
const FleetHttpTokensState = @import("fleet_http_tokens_state.zig").FleetHttpTokensState;

/// Describes the metadata options for the instances. Supported only for fleets
/// of type
/// `instant`.
pub const FleetInstanceMetadataOptionsRequest = struct {
    /// Enables or disables the HTTP metadata endpoint on your instances.
    ///
    /// * `enabled` - The HTTP metadata endpoint is enabled.
    ///
    /// * `disabled` - The HTTP metadata endpoint is disabled.
    http_endpoint: ?FleetInstanceMetadataEndpointState = null,

    /// The desired HTTP PUT response hop limit for instance metadata requests. The
    /// larger the
    /// number, the further instance metadata requests can travel.
    ///
    /// Default: `1`
    ///
    /// Possible values: Integers from 1 to 64
    http_put_response_hop_limit: ?i32 = null,

    /// Indicates whether IMDSv2 is required.
    ///
    /// * `optional` - IMDSv2 is optional, which means that you can use either
    /// IMDSv2 or IMDSv1.
    ///
    /// * `required` - IMDSv2 is required, which means that IMDSv1 is
    /// disabled, and you must use IMDSv2.
    http_tokens: ?FleetHttpTokensState = null,
};

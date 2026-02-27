const AwsApiCallAction = @import("aws_api_call_action.zig").AwsApiCallAction;
const DnsRequestAction = @import("dns_request_action.zig").DnsRequestAction;
const NetworkConnectionAction = @import("network_connection_action.zig").NetworkConnectionAction;
const PortProbeAction = @import("port_probe_action.zig").PortProbeAction;

/// Provides details about one of the following actions that affects or that was
/// taken on a resource:
///
/// * A remote IP address issued an Amazon Web Services API call
///
/// * A DNS request was received
///
/// * A remote IP address attempted to connect to an EC2 instance
///
/// * A remote IP address attempted a port probe on an EC2 instance
pub const Action = struct {
    /// The type of action that was detected. The possible action types are:
    ///
    /// * `NETWORK_CONNECTION`
    ///
    /// * `AWS_API_CALL`
    ///
    /// * `DNS_REQUEST`
    ///
    /// * `PORT_PROBE`
    action_type: ?[]const u8,

    /// Included if `ActionType` is `AWS_API_CALL`. Provides details about
    /// the API call that was detected.
    aws_api_call_action: ?AwsApiCallAction,

    /// Included if `ActionType` is `DNS_REQUEST`. Provides details about
    /// the DNS request that was detected.
    dns_request_action: ?DnsRequestAction,

    /// Included if `ActionType` is `NETWORK_CONNECTION`. Provides details
    /// about the network connection that was detected.
    network_connection_action: ?NetworkConnectionAction,

    /// Included if `ActionType` is `PORT_PROBE`. Provides details about
    /// the port probe that was detected.
    port_probe_action: ?PortProbeAction,

    pub const json_field_names = .{
        .action_type = "ActionType",
        .aws_api_call_action = "AwsApiCallAction",
        .dns_request_action = "DnsRequestAction",
        .network_connection_action = "NetworkConnectionAction",
        .port_probe_action = "PortProbeAction",
    };
};

const ActionLocalPortDetails = @import("action_local_port_details.zig").ActionLocalPortDetails;
const ActionRemoteIpDetails = @import("action_remote_ip_details.zig").ActionRemoteIpDetails;
const ActionRemotePortDetails = @import("action_remote_port_details.zig").ActionRemotePortDetails;

/// Provided if `ActionType` is `NETWORK_CONNECTION`. It provides
/// details about the attempted network connection that was detected.
pub const NetworkConnectionAction = struct {
    /// Indicates whether the network connection attempt was blocked.
    blocked: ?bool,

    /// The direction of the network connection request (`IN` or
    /// `OUT`).
    connection_direction: ?[]const u8,

    /// Information about the port on the EC2 instance.
    local_port_details: ?ActionLocalPortDetails,

    /// The protocol used to make the network connection request.
    ///
    /// Length Constraints: Minimum length of 1. Maximum length of 64.
    protocol: ?[]const u8,

    /// Information about the remote IP address that issued the network connection
    /// request.
    remote_ip_details: ?ActionRemoteIpDetails,

    /// Information about the port on the remote IP address.
    remote_port_details: ?ActionRemotePortDetails,

    pub const json_field_names = .{
        .blocked = "Blocked",
        .connection_direction = "ConnectionDirection",
        .local_port_details = "LocalPortDetails",
        .protocol = "Protocol",
        .remote_ip_details = "RemoteIpDetails",
        .remote_port_details = "RemotePortDetails",
    };
};

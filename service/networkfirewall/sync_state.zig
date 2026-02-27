const aws = @import("aws");

const Attachment = @import("attachment.zig").Attachment;
const PerObjectStatus = @import("per_object_status.zig").PerObjectStatus;

/// The status of the firewall endpoint and firewall policy configuration for a
/// single VPC subnet.
/// This is part of the FirewallStatus.
///
/// For each VPC subnet that you associate with a firewall, Network Firewall
/// does the
/// following:
///
/// * Instantiates a firewall endpoint in the subnet, ready to take traffic.
///
/// * Configures the endpoint with the current firewall policy settings, to
///   provide the
/// filtering behavior for the endpoint.
///
/// When you update a firewall, for example to add a subnet association or
/// change a rule
/// group in the firewall policy, the affected sync states reflect out-of-sync
/// or not ready
/// status until the changes are complete.
pub const SyncState = struct {
    /// The configuration and status for a single firewall subnet.
    /// For each configured subnet, Network Firewall creates the attachment by
    /// instantiating the firewall
    /// endpoint in the subnet so that it's ready to take traffic.
    attachment: ?Attachment,

    /// The configuration status of the firewall endpoint in a single VPC subnet.
    /// Network Firewall
    /// provides each endpoint with the rules that are configured in the firewall
    /// policy. Each time
    /// you add a subnet or modify the associated firewall policy, Network Firewall
    /// synchronizes the
    /// rules in the endpoint, so it can properly filter network traffic.
    config: ?[]const aws.map.MapEntry(PerObjectStatus),

    pub const json_field_names = .{
        .attachment = "Attachment",
        .config = "Config",
    };
};

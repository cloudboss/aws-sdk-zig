const aws = @import("aws");

const CapacityUsageSummary = @import("capacity_usage_summary.zig").CapacityUsageSummary;
const ConfigurationSyncState = @import("configuration_sync_state.zig").ConfigurationSyncState;
const FirewallStatusValue = @import("firewall_status_value.zig").FirewallStatusValue;
const SyncState = @import("sync_state.zig").SyncState;
const TransitGatewayAttachmentSyncState = @import("transit_gateway_attachment_sync_state.zig").TransitGatewayAttachmentSyncState;

/// Detailed information about the current status of a Firewall. You can
/// retrieve this for a firewall by calling DescribeFirewall and providing the
/// firewall name and ARN.
///
/// The firewall status indicates a combined status. It indicates whether all
/// subnets are up-to-date with the latest firewall configurations, which is
/// based on the sync states config values, and also whether all subnets have
/// their endpoints fully enabled, based on their sync states attachment values.
pub const FirewallStatus = struct {
    /// Describes the capacity usage of the resources contained in a firewall's
    /// reference sets. Network Firewall calculates the capacity usage by taking an
    /// aggregated count of all of the resources used by all of the reference sets
    /// in a firewall.
    capacity_usage_summary: ?CapacityUsageSummary,

    /// The configuration sync state for the firewall. This summarizes the `Config`
    /// settings in the `SyncStates` for this firewall status object.
    ///
    /// When you create a firewall or update its configuration, for example by
    /// adding a rule
    /// group to its firewall policy, Network Firewall distributes the configuration
    /// changes to all
    /// Availability Zones that have subnets defined for the firewall. This summary
    /// indicates whether the configuration
    /// changes have been applied everywhere.
    ///
    /// This status must be `IN_SYNC` for the firewall to be ready for use, but it
    /// doesn't indicate that the firewall is ready. The `Status` setting indicates
    /// firewall readiness. It's based on this setting and the readiness of the
    /// firewall endpoints to take traffic.
    configuration_sync_state_summary: ConfigurationSyncState,

    /// The readiness of the configured firewall to handle network traffic across
    /// all of the
    /// Availability Zones where you have it configured. This setting is `READY`
    /// only when
    /// the `ConfigurationSyncStateSummary` value is `IN_SYNC` and the
    /// `Attachment`
    /// `Status` values for all of the configured subnets are `READY`.
    status: FirewallStatusValue,

    /// Status for the subnets that you've configured in the firewall. This contains
    /// one array element per Availability Zone where you've configured a subnet in
    /// the firewall.
    ///
    /// These objects provide detailed information for the settings
    /// `ConfigurationSyncStateSummary` and `Status`.
    sync_states: ?[]const aws.map.MapEntry(SyncState),

    /// The synchronization state of the transit gateway attachment. This indicates
    /// whether the firewall's transit gateway configuration is properly
    /// synchronized and operational. Use this to verify that your transit gateway
    /// configuration changes have been applied.
    transit_gateway_attachment_sync_state: ?TransitGatewayAttachmentSyncState,

    pub const json_field_names = .{
        .capacity_usage_summary = "CapacityUsageSummary",
        .configuration_sync_state_summary = "ConfigurationSyncStateSummary",
        .status = "Status",
        .sync_states = "SyncStates",
        .transit_gateway_attachment_sync_state = "TransitGatewayAttachmentSyncState",
    };
};

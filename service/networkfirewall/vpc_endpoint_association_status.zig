const aws = @import("aws");

const AZSyncState = @import("az_sync_state.zig").AZSyncState;
const FirewallStatusValue = @import("firewall_status_value.zig").FirewallStatusValue;

/// Detailed information about the current status of a VpcEndpointAssociation.
/// You can retrieve this
/// by calling DescribeVpcEndpointAssociation and providing the VPC endpoint
/// association ARN.
pub const VpcEndpointAssociationStatus = struct {
    /// The list of the Availability Zone sync states for all subnets that are
    /// defined by the firewall.
    association_sync_state: ?[]const aws.map.MapEntry(AZSyncState),

    /// The readiness of the configured firewall endpoint to handle network traffic.
    status: FirewallStatusValue,

    pub const json_field_names = .{
        .association_sync_state = "AssociationSyncState",
        .status = "Status",
    };
};

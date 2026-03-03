const CreateNetworkAclAction = @import("create_network_acl_action.zig").CreateNetworkAclAction;
const CreateNetworkAclEntriesAction = @import("create_network_acl_entries_action.zig").CreateNetworkAclEntriesAction;
const DeleteNetworkAclEntriesAction = @import("delete_network_acl_entries_action.zig").DeleteNetworkAclEntriesAction;
const EC2AssociateRouteTableAction = @import("ec2_associate_route_table_action.zig").EC2AssociateRouteTableAction;
const EC2CopyRouteTableAction = @import("ec2_copy_route_table_action.zig").EC2CopyRouteTableAction;
const EC2CreateRouteAction = @import("ec2_create_route_action.zig").EC2CreateRouteAction;
const EC2CreateRouteTableAction = @import("ec2_create_route_table_action.zig").EC2CreateRouteTableAction;
const EC2DeleteRouteAction = @import("ec2_delete_route_action.zig").EC2DeleteRouteAction;
const EC2ReplaceRouteAction = @import("ec2_replace_route_action.zig").EC2ReplaceRouteAction;
const EC2ReplaceRouteTableAssociationAction = @import("ec2_replace_route_table_association_action.zig").EC2ReplaceRouteTableAssociationAction;
const FMSPolicyUpdateFirewallCreationConfigAction = @import("fms_policy_update_firewall_creation_config_action.zig").FMSPolicyUpdateFirewallCreationConfigAction;
const ReplaceNetworkAclAssociationAction = @import("replace_network_acl_association_action.zig").ReplaceNetworkAclAssociationAction;

/// Information about an individual action you can take to remediate a
/// violation.
pub const RemediationAction = struct {
    /// Information about the `CreateNetworkAcl` action in Amazon EC2.
    create_network_acl_action: ?CreateNetworkAclAction = null,

    /// Information about the `CreateNetworkAclEntries` action in Amazon EC2.
    create_network_acl_entries_action: ?CreateNetworkAclEntriesAction = null,

    /// Information about the `DeleteNetworkAclEntries` action in Amazon EC2.
    delete_network_acl_entries_action: ?DeleteNetworkAclEntriesAction = null,

    /// A description of a remediation action.
    description: ?[]const u8 = null,

    /// Information about the AssociateRouteTable action in the Amazon EC2 API.
    ec2_associate_route_table_action: ?EC2AssociateRouteTableAction = null,

    /// Information about the CopyRouteTable action in the Amazon EC2 API.
    ec2_copy_route_table_action: ?EC2CopyRouteTableAction = null,

    /// Information about the CreateRoute action in the Amazon EC2 API.
    ec2_create_route_action: ?EC2CreateRouteAction = null,

    /// Information about the CreateRouteTable action in the Amazon EC2 API.
    ec2_create_route_table_action: ?EC2CreateRouteTableAction = null,

    /// Information about the DeleteRoute action in the Amazon EC2 API.
    ec2_delete_route_action: ?EC2DeleteRouteAction = null,

    /// Information about the ReplaceRoute action in the Amazon EC2 API.
    ec2_replace_route_action: ?EC2ReplaceRouteAction = null,

    /// Information about the ReplaceRouteTableAssociation action in the Amazon EC2
    /// API.
    ec2_replace_route_table_association_action: ?EC2ReplaceRouteTableAssociationAction = null,

    /// The remedial action to take when updating a firewall configuration.
    fms_policy_update_firewall_creation_config_action: ?FMSPolicyUpdateFirewallCreationConfigAction = null,

    /// Information about the `ReplaceNetworkAclAssociation` action in Amazon EC2.
    replace_network_acl_association_action: ?ReplaceNetworkAclAssociationAction = null,

    pub const json_field_names = .{
        .create_network_acl_action = "CreateNetworkAclAction",
        .create_network_acl_entries_action = "CreateNetworkAclEntriesAction",
        .delete_network_acl_entries_action = "DeleteNetworkAclEntriesAction",
        .description = "Description",
        .ec2_associate_route_table_action = "EC2AssociateRouteTableAction",
        .ec2_copy_route_table_action = "EC2CopyRouteTableAction",
        .ec2_create_route_action = "EC2CreateRouteAction",
        .ec2_create_route_table_action = "EC2CreateRouteTableAction",
        .ec2_delete_route_action = "EC2DeleteRouteAction",
        .ec2_replace_route_action = "EC2ReplaceRouteAction",
        .ec2_replace_route_table_association_action = "EC2ReplaceRouteTableAssociationAction",
        .fms_policy_update_firewall_creation_config_action = "FMSPolicyUpdateFirewallCreationConfigAction",
        .replace_network_acl_association_action = "ReplaceNetworkAclAssociationAction",
    };
};

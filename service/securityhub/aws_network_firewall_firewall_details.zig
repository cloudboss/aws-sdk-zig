const AwsNetworkFirewallFirewallSubnetMappingsDetails = @import("aws_network_firewall_firewall_subnet_mappings_details.zig").AwsNetworkFirewallFirewallSubnetMappingsDetails;

/// Details about an Network Firewall firewall.
pub const AwsNetworkFirewallFirewallDetails = struct {
    /// Whether the firewall is protected from deletion. If set to `true`, then the
    /// firewall cannot be deleted.
    delete_protection: ?bool,

    /// A description of the firewall.
    description: ?[]const u8,

    /// The ARN of the firewall.
    firewall_arn: ?[]const u8,

    /// The identifier of the firewall.
    firewall_id: ?[]const u8,

    /// A descriptive name of the firewall.
    firewall_name: ?[]const u8,

    /// The ARN of the firewall policy.
    firewall_policy_arn: ?[]const u8,

    /// Whether the firewall is protected from a change to the firewall policy. If
    /// set to `true`, you cannot associate a different policy with the firewall.
    firewall_policy_change_protection: ?bool,

    /// Whether the firewall is protected from a change to the subnet associations.
    /// If set to `true`, you cannot map different subnets to the firewall.
    subnet_change_protection: ?bool,

    /// The public subnets that Network Firewall uses for the firewall. Each subnet
    /// must belong to a different Availability Zone.
    subnet_mappings: ?[]const AwsNetworkFirewallFirewallSubnetMappingsDetails,

    /// The identifier of the VPC where the firewall is used.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .delete_protection = "DeleteProtection",
        .description = "Description",
        .firewall_arn = "FirewallArn",
        .firewall_id = "FirewallId",
        .firewall_name = "FirewallName",
        .firewall_policy_arn = "FirewallPolicyArn",
        .firewall_policy_change_protection = "FirewallPolicyChangeProtection",
        .subnet_change_protection = "SubnetChangeProtection",
        .subnet_mappings = "SubnetMappings",
        .vpc_id = "VpcId",
    };
};

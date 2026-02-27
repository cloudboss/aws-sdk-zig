const MutationProtectionStatus = @import("mutation_protection_status.zig").MutationProtectionStatus;
const FirewallRuleGroupAssociationStatus = @import("firewall_rule_group_association_status.zig").FirewallRuleGroupAssociationStatus;

/// An association between a firewall rule group and a VPC, which enables DNS
/// filtering for
/// the VPC.
pub const FirewallRuleGroupAssociation = struct {
    /// The Amazon Resource Name (ARN) of the firewall rule group association.
    arn: ?[]const u8,

    /// The date and time that the association was created, in Unix time format and
    /// Coordinated Universal Time (UTC).
    creation_time: ?[]const u8,

    /// A unique string defined by you to identify the request. This allows you to
    /// retry failed
    /// requests without the risk of running the operation twice. This can be any
    /// unique string,
    /// for example, a timestamp.
    creator_request_id: ?[]const u8,

    /// The unique identifier of the firewall rule group.
    firewall_rule_group_id: ?[]const u8,

    /// The identifier for the association.
    id: ?[]const u8,

    /// The owner of the association, used only for associations that are not
    /// managed by you. If you use Firewall Manager to
    /// manage your DNS Firewalls, then this reports Firewall Manager as the managed
    /// owner.
    managed_owner_name: ?[]const u8,

    /// The date and time that the association was last modified, in Unix time
    /// format and Coordinated Universal Time (UTC).
    modification_time: ?[]const u8,

    /// If enabled, this setting disallows modification or removal of the
    /// association, to help prevent against accidentally altering DNS firewall
    /// protections.
    mutation_protection: ?MutationProtectionStatus,

    /// The name of the association.
    name: ?[]const u8,

    /// The setting that determines the processing order of the rule group among the
    /// rule groups that are associated with a single VPC. DNS Firewall
    /// filters VPC traffic starting from rule group with the lowest numeric
    /// priority setting.
    priority: ?i32,

    /// The current status of the association.
    status: ?FirewallRuleGroupAssociationStatus,

    /// Additional information about the status of the response, if available.
    status_message: ?[]const u8,

    /// The unique identifier of the VPC that is associated with the rule group.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .creator_request_id = "CreatorRequestId",
        .firewall_rule_group_id = "FirewallRuleGroupId",
        .id = "Id",
        .managed_owner_name = "ManagedOwnerName",
        .modification_time = "ModificationTime",
        .mutation_protection = "MutationProtection",
        .name = "Name",
        .priority = "Priority",
        .status = "Status",
        .status_message = "StatusMessage",
        .vpc_id = "VpcId",
    };
};

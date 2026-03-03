/// Configures one or more IP set references for a Suricata-compatible rule
/// group. This is used in CreateRuleGroup or UpdateRuleGroup. An IP set
/// reference is a rule variable that references resources that you create and
/// manage in another Amazon Web Services service, such as an Amazon VPC prefix
/// list. Network Firewall IP set references enable you to dynamically update
/// the contents of your rules. When you create, update, or delete the resource
/// you are referencing in your rule, Network Firewall automatically updates the
/// rule's content with the changes. For more information about IP set
/// references in Network Firewall, see [Using IP set
/// references](https://docs.aws.amazon.com/network-firewall/latest/developerguide/rule-groups-ip-set-references) in the *Network Firewall Developer Guide*.
///
/// Network Firewall currently supports [Amazon VPC prefix
/// lists](https://docs.aws.amazon.com/vpc/latest/userguide/managed-prefix-lists.html) and [resource groups](https://docs.aws.amazon.com/network-firewall/latest/developerguide/rule-groups-ip-set-references.html#rule-groups-referencing-resource-groups) in IP set references.
pub const IPSetReference = struct {
    /// The Amazon Resource Name (ARN) of the resource that you are referencing in
    /// your rule group.
    reference_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .reference_arn = "ReferenceArn",
    };
};

/// The properties of a managed product, such as an Amazon Web Services Managed
/// Rules rule group or an Amazon Web Services Marketplace managed rule group.
pub const ManagedProductDescriptor = struct {
    /// Indicates whether the rule group provides an advanced set of protections,
    /// such as the the Amazon Web Services Managed Rules rule groups that
    /// are used for WAF intelligent threat mitigation.
    is_advanced_managed_rule_set: bool = false,

    /// Indicates whether the rule group is versioned.
    is_versioning_supported: bool = false,

    /// The name of the managed rule group. For example,
    /// `AWSManagedRulesAnonymousIpList` or `AWSManagedRulesATPRuleSet`.
    managed_rule_set_name: ?[]const u8 = null,

    /// A short description of the managed rule group.
    product_description: ?[]const u8 = null,

    /// A unique identifier for the rule group. This ID is returned in the responses
    /// to create and list commands. You provide it to operations like update and
    /// delete.
    product_id: ?[]const u8 = null,

    /// For Amazon Web Services Marketplace managed rule groups only, the link to
    /// the rule group product page.
    product_link: ?[]const u8 = null,

    /// The display name for the managed rule group. For example, `Anonymous IP
    /// list` or `Account takeover prevention`.
    product_title: ?[]const u8 = null,

    /// The Amazon resource name (ARN) of the Amazon Simple Notification Service SNS
    /// topic that's used to provide notification of changes
    /// to the managed rule group. You can subscribe to the SNS topic to receive
    /// notifications when
    /// the managed rule group is modified, such as for new versions and for version
    /// expiration.
    /// For more information, see the [Amazon Simple Notification Service Developer
    /// Guide](https://docs.aws.amazon.com/sns/latest/dg/welcome.html).
    sns_topic_arn: ?[]const u8 = null,

    /// The name of the managed rule group vendor. You use this, along with the rule
    /// group name, to identify a rule group.
    vendor_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .is_advanced_managed_rule_set = "IsAdvancedManagedRuleSet",
        .is_versioning_supported = "IsVersioningSupported",
        .managed_rule_set_name = "ManagedRuleSetName",
        .product_description = "ProductDescription",
        .product_id = "ProductId",
        .product_link = "ProductLink",
        .product_title = "ProductTitle",
        .sns_topic_arn = "SnsTopicArn",
        .vendor_name = "VendorName",
    };
};

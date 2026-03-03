/// High-level information about the managed rule group that your own rule group
/// is copied from. You can use the the metadata to track version updates made
/// to the originating rule group. You can retrieve all objects for a rule group
/// by calling
/// [DescribeRuleGroup](https://docs.aws.amazon.com/network-firewall/latest/APIReference/API_DescribeRuleGroup.html).
pub const SourceMetadata = struct {
    /// The Amazon Resource Name (ARN) of the rule group that your own rule group is
    /// copied from.
    source_arn: ?[]const u8 = null,

    /// The update token of the Amazon Web Services managed rule group that your own
    /// rule group is copied from. To determine the update token for the managed
    /// rule group, call
    /// [DescribeRuleGroup](https://docs.aws.amazon.com/network-firewall/latest/APIReference/API_DescribeRuleGroup.html#networkfirewall-DescribeRuleGroup-response-UpdateToken).
    source_update_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .source_arn = "SourceArn",
        .source_update_token = "SourceUpdateToken",
    };
};

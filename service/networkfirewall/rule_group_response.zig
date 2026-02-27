const AnalysisResult = @import("analysis_result.zig").AnalysisResult;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;
const SourceMetadata = @import("source_metadata.zig").SourceMetadata;
const SummaryConfiguration = @import("summary_configuration.zig").SummaryConfiguration;
const Tag = @import("tag.zig").Tag;
const RuleGroupType = @import("rule_group_type.zig").RuleGroupType;

/// The high-level properties of a rule group. This, along with the RuleGroup,
/// define the rule group. You can retrieve all objects for a rule group by
/// calling DescribeRuleGroup.
pub const RuleGroupResponse = struct {
    /// The list of analysis results for `AnalyzeRuleGroup`. If you set
    /// `AnalyzeRuleGroup` to `TRUE` in CreateRuleGroup, UpdateRuleGroup, or
    /// DescribeRuleGroup, Network Firewall analyzes the rule group and identifies
    /// the rules that might adversely effect your firewall's functionality. For
    /// example, if Network Firewall detects a rule that's routing traffic
    /// asymmetrically, which impacts the service's ability to properly process
    /// traffic, the service includes the rule in the list of analysis results.
    analysis_results: ?[]const AnalysisResult,

    /// The maximum operating resources that this rule group can use. Rule group
    /// capacity is fixed at creation.
    /// When you update a rule group, you are limited to this capacity. When you
    /// reference a rule group
    /// from a firewall policy, Network Firewall reserves this capacity for the rule
    /// group.
    ///
    /// You can retrieve the capacity that would be required for a rule group before
    /// you create the rule group by calling
    /// CreateRuleGroup with `DryRun` set to `TRUE`.
    capacity: ?i32,

    /// The number of capacity units currently consumed by the rule group rules.
    consumed_capacity: ?i32,

    /// A description of the rule group.
    description: ?[]const u8,

    /// A complex type that contains the Amazon Web Services KMS encryption
    /// configuration settings for your rule group.
    encryption_configuration: ?EncryptionConfiguration,

    /// The last time that the rule group was changed.
    last_modified_time: ?i64,

    /// The number of firewall policies that use this rule group.
    number_of_associations: ?i32,

    /// The Amazon Resource Name (ARN) of the rule group.
    ///
    /// If this response is for a create request that had `DryRun` set to
    /// `TRUE`, then this ARN is a placeholder that isn't attached to a valid
    /// resource.
    rule_group_arn: []const u8,

    /// The unique identifier for the rule group.
    rule_group_id: []const u8,

    /// The descriptive name of the rule group. You can't change the name of a rule
    /// group after you create it.
    rule_group_name: []const u8,

    /// Detailed information about the current status of a rule group.
    rule_group_status: ?ResourceStatus,

    /// The Amazon Resource Name (ARN) of the Amazon Simple Notification Service SNS
    /// topic that's
    /// used to record changes to the managed rule group. You can subscribe to the
    /// SNS topic to receive
    /// notifications when the managed rule group is modified, such as for new
    /// versions and for version
    /// expiration. For more information, see the [Amazon Simple Notification
    /// Service Developer
    /// Guide.](https://docs.aws.amazon.com/sns/latest/dg/welcome.html).
    sns_topic: ?[]const u8,

    /// A complex type that contains metadata about the rule group that your own
    /// rule group is copied from. You can use the metadata to track the version
    /// updates made to the originating rule group.
    source_metadata: ?SourceMetadata,

    /// A complex type containing the currently selected rule option fields that
    /// will be displayed for rule summarization returned by
    /// DescribeRuleGroupSummary.
    ///
    /// * The `RuleOptions` specified in SummaryConfiguration
    ///
    /// * Rule metadata organization preferences
    summary_configuration: ?SummaryConfiguration,

    /// The key:value pairs to associate with the resource.
    tags: ?[]const Tag,

    /// Indicates whether the rule group is stateless or stateful. If the rule group
    /// is stateless, it contains
    /// stateless rules. If it is stateful, it contains stateful rules.
    type: ?RuleGroupType,

    pub const json_field_names = .{
        .analysis_results = "AnalysisResults",
        .capacity = "Capacity",
        .consumed_capacity = "ConsumedCapacity",
        .description = "Description",
        .encryption_configuration = "EncryptionConfiguration",
        .last_modified_time = "LastModifiedTime",
        .number_of_associations = "NumberOfAssociations",
        .rule_group_arn = "RuleGroupArn",
        .rule_group_id = "RuleGroupId",
        .rule_group_name = "RuleGroupName",
        .rule_group_status = "RuleGroupStatus",
        .sns_topic = "SnsTopic",
        .source_metadata = "SourceMetadata",
        .summary_configuration = "SummaryConfiguration",
        .tags = "Tags",
        .type = "Type",
    };
};

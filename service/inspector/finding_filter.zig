const Attribute = @import("attribute.zig").Attribute;
const TimestampRange = @import("timestamp_range.zig").TimestampRange;
const Severity = @import("severity.zig").Severity;

/// This data type is used as a request parameter in the ListFindings
/// action.
pub const FindingFilter = struct {
    /// For a record to match a filter, one of the values that is specified for this
    /// data
    /// type property must be the exact match of the value of the **agentId**
    /// property of the Finding data type.
    agent_ids: ?[]const []const u8 = null,

    /// For a record to match a filter, the list of values that are specified for
    /// this data
    /// type property must be contained in the list of values of the **attributes**
    /// property of the Finding data type.
    attributes: ?[]const Attribute = null,

    /// For a record to match a filter, one of the values that is specified for this
    /// data
    /// type property must be the exact match of the value of the
    /// **autoScalingGroup** property of the Finding data
    /// type.
    auto_scaling_groups: ?[]const []const u8 = null,

    /// The time range during which the finding is generated.
    creation_time_range: ?TimestampRange = null,

    /// For a record to match a filter, one of the values that is specified for this
    /// data
    /// type property must be the exact match of the value of the **ruleName**
    /// property of the Finding data type.
    rule_names: ?[]const []const u8 = null,

    /// For a record to match a filter, one of the values that is specified for this
    /// data
    /// type property must be the exact match of the value of the
    /// **rulesPackageArn** property of the Finding data
    /// type.
    rules_package_arns: ?[]const []const u8 = null,

    /// For a record to match a filter, one of the values that is specified for this
    /// data
    /// type property must be the exact match of the value of the **severity**
    /// property of the Finding data type.
    severities: ?[]const Severity = null,

    /// For a record to match a filter, the value that is specified for this data
    /// type
    /// property must be contained in the list of values of the **userAttributes**
    /// property of the Finding data
    /// type.
    user_attributes: ?[]const Attribute = null,

    pub const json_field_names = .{
        .agent_ids = "agentIds",
        .attributes = "attributes",
        .auto_scaling_groups = "autoScalingGroups",
        .creation_time_range = "creationTimeRange",
        .rule_names = "ruleNames",
        .rules_package_arns = "rulesPackageArns",
        .severities = "severities",
        .user_attributes = "userAttributes",
    };
};

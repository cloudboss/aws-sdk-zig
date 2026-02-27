const AwsSecurityFindingFilters = @import("aws_security_finding_filters.zig").AwsSecurityFindingFilters;

/// Contains information about a Security Hub insight.
pub const Insight = struct {
    /// One or more attributes used to filter the findings included in the insight.
    /// You can filter by up to ten finding attributes. For each attribute, you can
    /// provide up to 20 filter values.
    /// The insight only includes findings that match the criteria defined in the
    /// filters.
    filters: AwsSecurityFindingFilters,

    /// The grouping attribute for the insight's findings. Indicates how to group
    /// the matching
    /// findings, and identifies the type of item that the insight applies to. For
    /// example, if an
    /// insight is grouped by resource identifier, then the insight produces a list
    /// of resource
    /// identifiers.
    group_by_attribute: []const u8,

    /// The ARN of a Security Hub insight.
    insight_arn: []const u8,

    /// The name of a Security Hub insight.
    name: []const u8,

    pub const json_field_names = .{
        .filters = "Filters",
        .group_by_attribute = "GroupByAttribute",
        .insight_arn = "InsightArn",
        .name = "Name",
    };
};

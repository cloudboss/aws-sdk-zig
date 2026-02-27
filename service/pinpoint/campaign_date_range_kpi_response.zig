const BaseKpiResult = @import("base_kpi_result.zig").BaseKpiResult;

/// Provides the results of a query that retrieved the data for a standard
/// metric that applies to a campaign, and provides information about that
/// query.
pub const CampaignDateRangeKpiResponse = struct {
    /// The unique identifier for the application that the metric applies to.
    application_id: []const u8,

    /// The unique identifier for the campaign that the metric applies to.
    campaign_id: []const u8,

    /// The last date and time of the date range that was used to filter the query
    /// results, in extended ISO 8601 format. The date range is inclusive.
    end_time: i64,

    /// The name of the metric, also referred to as a *key performance indicator
    /// (KPI)*, that the data was retrieved for. This value describes the associated
    /// metric and consists of two or more terms, which are comprised of lowercase
    /// alphanumeric characters, separated by a hyphen. For a list of possible
    /// values, see the [Amazon Pinpoint Developer
    /// Guide](https://docs.aws.amazon.com/pinpoint/latest/developerguide/analytics-standard-metrics.html).
    kpi_name: []const u8,

    /// An array of objects that contains the results of the query. Each object
    /// contains the value for the metric and metadata about that value.
    kpi_result: BaseKpiResult,

    /// The string to use in a subsequent request to get the next page of results in
    /// a paginated response. This value is null for the Campaign Metrics resource
    /// because the resource returns all results in a single page.
    next_token: ?[]const u8,

    /// The first date and time of the date range that was used to filter the query
    /// results, in extended ISO 8601 format. The date range is inclusive.
    start_time: i64,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .campaign_id = "CampaignId",
        .end_time = "EndTime",
        .kpi_name = "KpiName",
        .kpi_result = "KpiResult",
        .next_token = "NextToken",
        .start_time = "StartTime",
    };
};

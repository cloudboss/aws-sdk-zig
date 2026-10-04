const aws = @import("aws");

const CreatedByInfo = @import("created_by_info.zig").CreatedByInfo;
const MetricCreationMethod = @import("metric_creation_method.zig").MetricCreationMethod;
const AvailableFilter = @import("available_filter.zig").AvailableFilter;
const MetricCalculation = @import("metric_calculation.zig").MetricCalculation;
const TrendIndicator = @import("trend_indicator.zig").TrendIndicator;
const MetricStatus = @import("metric_status.zig").MetricStatus;
const MetricType = @import("metric_type.zig").MetricType;
const MetricUnit = @import("metric_unit.zig").MetricUnit;

/// Contains the full definition of a metric, including its calculation, unit,
/// status, and trend indicator.
pub const MetricDefinition = struct {
    /// The Amazon Resource Name (ARN) of the metric. May be qualified with `$SAVED`
    /// or `$LATEST`.
    arn: []const u8,

    /// The category of the metric.
    category: []const u8,

    /// The timestamp of when the metric was created.
    created_time: ?i64 = null,

    /// The user that created the metric. The creator for metrics created through
    /// the CreateMetric API will be `Amazon Connect API`.
    created_user: ?CreatedByInfo = null,

    /// The method used to create the metric. Valid values: `SERVICE_LEVEL_BUILDER`
    /// (created with the guided service-level experience) | `METRIC_BUILDER`
    /// (created with the free-form metric builder).
    creation_method: ?MetricCreationMethod = null,

    /// The default stat aggregation for the metric.
    default_stat: ?[]const u8 = null,

    /// The description of the metric.
    description: ?[]const u8 = null,

    /// The earliest time that can be queried for this metric.
    effective_time: ?i64 = null,

    /// The filters applied to the metric.
    filters: []const AvailableFilter,

    /// The groupings available for this metric.
    groupings: []const []const u8,

    /// The identifier of the metric.
    id: []const u8,

    /// The region where the metric was last modified.
    last_modified_region: ?[]const u8 = null,

    /// The timestamp of when the metric was last modified.
    last_modified_time: ?i64 = null,

    /// The user that last modified the metric. For modifications made through the
    /// API, this will be `Amazon Connect API`.
    last_modified_user: ?CreatedByInfo = null,

    /// The calculation definition for the metric.
    metric_calculation: ?MetricCalculation = null,

    /// The name of the metric.
    name: []const u8,

    /// How an increase in the metric value should be interpreted. Valid values:
    /// `POSITIVE`, `NEUTRAL`, `NEGATIVE`.
    positive_trend_indicator: ?TrendIndicator = null,

    /// The primary event source for the metric data.
    primary_event_source: ?[]const u8 = null,

    /// The timestamp type that determines where the metric appears on a time
    /// series.
    primary_event_source_effective_timestamp_type: ?[]const u8 = null,

    /// The minimum interval, in seconds, between data refreshes for this metric.
    refresh_rate: i64 = 0,

    /// The publish status of the metric. Valid values: `PUBLISHED` | `SAVED`.
    status: ?MetricStatus = null,

    /// The stat aggregations available for this metric.
    supported_stats: ?[]const []const u8 = null,

    /// Specifies whether the metric can be used as a component of custom metrics.
    supports_custom_calculation: bool = false,

    /// Specifies whether the metric can be used inside aggregating statistical
    /// functions (SUM, AVG, etc.) in custom metric calculations.
    supports_preaggregate_calculation: bool = false,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of the metric. Valid values: `AWS_MANAGED` | `CUSTOMER_MANAGED`.
    @"type": MetricType,

    /// The display unit for the metric's data.
    unit: MetricUnit,

    pub const json_field_names = .{
        .arn = "Arn",
        .category = "Category",
        .created_time = "CreatedTime",
        .created_user = "CreatedUser",
        .creation_method = "CreationMethod",
        .default_stat = "DefaultStat",
        .description = "Description",
        .effective_time = "EffectiveTime",
        .filters = "Filters",
        .groupings = "Groupings",
        .id = "Id",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .last_modified_user = "LastModifiedUser",
        .metric_calculation = "MetricCalculation",
        .name = "Name",
        .positive_trend_indicator = "PositiveTrendIndicator",
        .primary_event_source = "PrimaryEventSource",
        .primary_event_source_effective_timestamp_type = "PrimaryEventSourceEffectiveTimestampType",
        .refresh_rate = "RefreshRate",
        .status = "Status",
        .supported_stats = "SupportedStats",
        .supports_custom_calculation = "SupportsCustomCalculation",
        .supports_preaggregate_calculation = "SupportsPreaggregateCalculation",
        .tags = "Tags",
        .@"type" = "Type",
        .unit = "Unit",
    };
};

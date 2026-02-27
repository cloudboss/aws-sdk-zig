const AccountAggregationSource = @import("account_aggregation_source.zig").AccountAggregationSource;
const AggregatorFilters = @import("aggregator_filters.zig").AggregatorFilters;
const OrganizationAggregationSource = @import("organization_aggregation_source.zig").OrganizationAggregationSource;

/// The details about the configuration aggregator, including
/// information about source accounts, regions, and metadata of the
/// aggregator.
pub const ConfigurationAggregator = struct {
    /// Provides a list of source accounts and regions to be
    /// aggregated.
    account_aggregation_sources: ?[]const AccountAggregationSource,

    /// An object to filter the data you specify for an aggregator.
    aggregator_filters: ?AggregatorFilters,

    /// The Amazon Resource Name (ARN) of the aggregator.
    configuration_aggregator_arn: ?[]const u8,

    /// The name of the aggregator.
    configuration_aggregator_name: ?[]const u8,

    /// Amazon Web Services service that created the configuration aggregator.
    created_by: ?[]const u8,

    /// The time stamp when the configuration aggregator was
    /// created.
    creation_time: ?i64,

    /// The time of the last update.
    last_updated_time: ?i64,

    /// Provides an organization and list of regions to be
    /// aggregated.
    organization_aggregation_source: ?OrganizationAggregationSource,

    pub const json_field_names = .{
        .account_aggregation_sources = "AccountAggregationSources",
        .aggregator_filters = "AggregatorFilters",
        .configuration_aggregator_arn = "ConfigurationAggregatorArn",
        .configuration_aggregator_name = "ConfigurationAggregatorName",
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .last_updated_time = "LastUpdatedTime",
        .organization_aggregation_source = "OrganizationAggregationSource",
    };
};

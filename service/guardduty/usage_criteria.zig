const DataSource = @import("data_source.zig").DataSource;
const UsageFeature = @import("usage_feature.zig").UsageFeature;

/// Contains information about the criteria used to query usage statistics.
pub const UsageCriteria = struct {
    /// The account IDs to aggregate usage statistics from.
    account_ids: ?[]const []const u8,

    /// The data sources to aggregate usage statistics from.
    data_sources: ?[]const DataSource,

    /// The features to aggregate usage statistics from.
    features: ?[]const UsageFeature,

    /// The resources to aggregate usage statistics from. Only accepts exact
    /// resource
    /// names.
    resources: ?[]const []const u8,

    pub const json_field_names = .{
        .account_ids = "AccountIds",
        .data_sources = "DataSources",
        .features = "Features",
        .resources = "Resources",
    };
};

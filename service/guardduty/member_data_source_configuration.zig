const DataSourceConfigurationsResult = @import("data_source_configurations_result.zig").DataSourceConfigurationsResult;
const MemberFeaturesConfigurationResult = @import("member_features_configuration_result.zig").MemberFeaturesConfigurationResult;

/// Contains information on which data sources are enabled for a member account.
pub const MemberDataSourceConfiguration = struct {
    /// The account ID for the member account.
    account_id: []const u8,

    /// Contains information on the status of data sources for the account.
    data_sources: DataSourceConfigurationsResult,

    /// Contains information about the status of the features for the member
    /// account.
    features: ?[]const MemberFeaturesConfigurationResult = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .data_sources = "DataSources",
        .features = "Features",
    };
};

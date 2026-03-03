const DataSourcesFreeTrial = @import("data_sources_free_trial.zig").DataSourcesFreeTrial;
const FreeTrialFeatureConfigurationResult = @import("free_trial_feature_configuration_result.zig").FreeTrialFeatureConfigurationResult;

/// Provides details of the GuardDuty member account that uses a free trial
/// service.
pub const AccountFreeTrialInfo = struct {
    /// The account identifier of the GuardDuty member account.
    account_id: ?[]const u8 = null,

    /// Describes the data source enabled for the GuardDuty member account.
    data_sources: ?DataSourcesFreeTrial = null,

    /// A list of features enabled for the GuardDuty account.
    features: ?[]const FreeTrialFeatureConfigurationResult = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .data_sources = "DataSources",
        .features = "Features",
    };
};

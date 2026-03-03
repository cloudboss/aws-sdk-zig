/// A parameter to configure deletion protection. Deletion protection prevents a
/// user from
/// deleting a configuration profile or an environment if AppConfig has called
/// either
/// [GetLatestConfiguration](https://docs.aws.amazon.com/appconfig/2019-10-09/APIReference/API_appconfigdata_GetLatestConfiguration.html) or for the
/// configuration profile or from the environment during the specified interval.
///
/// The default interval specified by `ProtectionPeriodInMinutes` is 60.
/// `DeletionProtectionCheck` skips configuration profiles and environments that
/// were created in the past hour.
pub const DeletionProtectionSettings = struct {
    /// A parameter that indicates if deletion protection is enabled or not.
    enabled: ?bool = null,

    /// The time interval during which AppConfig monitors for calls to
    /// [GetLatestConfiguration](https://docs.aws.amazon.com/appconfig/2019-10-09/APIReference/API_appconfigdata_GetLatestConfiguration.html) or for a
    /// configuration profile or from an environment. AppConfig returns an error if
    /// a
    /// user calls or for the designated configuration profile or
    /// environment. To bypass the error and delete a configuration profile or an
    /// environment,
    /// specify `BYPASS` for the `DeletionProtectionCheck` parameter for
    /// either or .
    protection_period_in_minutes: ?i32 = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .protection_period_in_minutes = "ProtectionPeriodInMinutes",
    };
};

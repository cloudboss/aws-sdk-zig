/// Describes criteria to restrict the results when listing platform versions.
///
/// The filter is evaluated as follows: `Type Operator Values[1]`
pub const PlatformFilter = struct {
    /// The operator to apply to the `Type` with each of the
    /// `Values`.
    ///
    /// Valid values: `=` | `!=` |
    /// `` | `>=` |
    /// `contains` | `begins_with` | `ends_with`
    operator: ?[]const u8 = null,

    /// The platform version attribute to which the filter values are applied.
    ///
    /// Valid values: `PlatformName` | `PlatformVersion` |
    /// `PlatformStatus` | `PlatformBranchName` |
    /// `PlatformLifecycleState` | `PlatformOwner` |
    /// `SupportedTier` | `SupportedAddon` |
    /// `ProgrammingLanguageName` | `OperatingSystemName`
    @"type": ?[]const u8 = null,

    /// The list of values applied to the filtering platform version attribute. Only
    /// one value is supported
    /// for all current operators.
    ///
    /// The following list shows valid filter values for some filter attributes.
    ///
    /// * `PlatformStatus`: `Creating` | `Failed` |
    /// `Ready` | `Deleting` | `Deleted`
    ///
    /// * `PlatformLifecycleState`: `recommended`
    ///
    /// * `SupportedTier`: `WebServer/Standard` |
    /// `Worker/SQS/HTTP`
    ///
    /// * `SupportedAddon`: `Log/S3` | `Monitoring/Healthd` |
    /// `WorkerDaemon/SQSD`
    values: ?[]const []const u8 = null,
};

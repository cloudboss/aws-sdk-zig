const RestoreTestingRecoveryPointSelectionAlgorithm = @import("restore_testing_recovery_point_selection_algorithm.zig").RestoreTestingRecoveryPointSelectionAlgorithm;
const RestoreTestingRecoveryPointType = @import("restore_testing_recovery_point_type.zig").RestoreTestingRecoveryPointType;

/// `RecoveryPointSelection` has five parameters (three required and two
/// optional). The values you specify determine which recovery point is included
/// in the restore
/// test. You must indicate with `Algorithm` if you want the latest recovery
/// point
/// within your `SelectionWindowDays` or if you want a random recovery point,
/// and
/// you must indicate through `IncludeVaults` from which vaults the recovery
/// points
/// can be chosen.
///
/// `Algorithm` (*required*) Valid values:
/// "`LATEST_WITHIN_WINDOW`" or "`RANDOM_WITHIN_WINDOW`".
///
/// `Recovery point types` (*required*) Valid values:
/// "`SNAPSHOT`" and/or "`CONTINUOUS`". Include `SNAPSHOT`
/// to restore only snapshot recovery points; include `CONTINUOUS` to restore
/// continuous recovery points (point in time restore / PITR); use both to
/// restore either a
/// snapshot or a continuous recovery point. The recovery point will be
/// determined by the value
/// for `Algorithm`.
///
/// `IncludeVaults` (*required*). You must include one or more
/// backup vaults. Use the wildcard ["*"] or specific ARNs.
///
/// `SelectionWindowDays` (*optional*) Value must be an
/// integer (in days) from 1 to 365. If not included, the value defaults to
/// `30`.
///
/// `ExcludeVaults` (*optional*). You can choose to input one
/// or more specific backup vault ARNs to exclude those vaults' contents from
/// restore
/// eligibility. Or, you can include a list of selectors. If this parameter and
/// its value are
/// not included, it defaults to empty list.
pub const RestoreTestingRecoveryPointSelection = struct {
    /// Acceptable values include "LATEST_WITHIN_WINDOW" or
    /// "RANDOM_WITHIN_WINDOW"
    algorithm: ?RestoreTestingRecoveryPointSelectionAlgorithm = null,

    /// Accepted values include specific ARNs or list of selectors.
    /// Defaults to empty list if not listed.
    exclude_vaults: ?[]const []const u8 = null,

    /// Accepted values include wildcard ["*"] or by specific ARNs or
    /// ARN wilcard replacement
    /// ["arn:aws:backup:us-west-2:123456789012:backup-vault:asdf", ...]
    /// ["arn:aws:backup:*:*:backup-vault:asdf-*", ...]
    include_vaults: ?[]const []const u8 = null,

    /// These are the types of recovery points.
    ///
    /// Include `SNAPSHOT`
    /// to restore only snapshot recovery points; include `CONTINUOUS` to restore
    /// continuous recovery points (point in time restore / PITR); use both to
    /// restore either a
    /// snapshot or a continuous recovery point. The recovery point will be
    /// determined by the value
    /// for `Algorithm`.
    recovery_point_types: ?[]const RestoreTestingRecoveryPointType = null,

    /// Accepted values are integers from 1 to 365.
    selection_window_days: i32 = 0,

    pub const json_field_names = .{
        .algorithm = "Algorithm",
        .exclude_vaults = "ExcludeVaults",
        .include_vaults = "IncludeVaults",
        .recovery_point_types = "RecoveryPointTypes",
        .selection_window_days = "SelectionWindowDays",
    };
};

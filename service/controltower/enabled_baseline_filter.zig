const EnabledBaselineDriftStatus = @import("enabled_baseline_drift_status.zig").EnabledBaselineDriftStatus;
const EnablementStatus = @import("enablement_status.zig").EnablementStatus;

/// A filter applied on the `ListEnabledBaseline` operation. Allowed filters are
/// `baselineIdentifiers` and `targetIdentifiers`. The filter can be applied for
/// either, or both.
pub const EnabledBaselineFilter = struct {
    /// Identifiers for the `Baseline` objects returned as part of the filter
    /// operation.
    baseline_identifiers: ?[]const []const u8,

    /// A list of `EnabledBaselineDriftStatus` items for enabled baselines.
    inheritance_drift_statuses: ?[]const EnabledBaselineDriftStatus,

    /// An optional filter that sets up a list of `parentIdentifiers` to filter the
    /// results of the `ListEnabledBaseline` output.
    parent_identifiers: ?[]const []const u8,

    /// A list of `EnablementStatus` items.
    statuses: ?[]const EnablementStatus,

    /// Identifiers for the targets of the `Baseline` filter operation.
    target_identifiers: ?[]const []const u8,

    pub const json_field_names = .{
        .baseline_identifiers = "baselineIdentifiers",
        .inheritance_drift_statuses = "inheritanceDriftStatuses",
        .parent_identifiers = "parentIdentifiers",
        .statuses = "statuses",
        .target_identifiers = "targetIdentifiers",
    };
};

const DriftStatus = @import("drift_status.zig").DriftStatus;
const EnablementStatus = @import("enablement_status.zig").EnablementStatus;

/// A structure that returns a set of control identifiers, the control status
/// for each control in the set, and the drift status for each control in the
/// set.
pub const EnabledControlFilter = struct {
    /// The set of `controlIdentifier` returned by the filter.
    control_identifiers: ?[]const []const u8,

    /// A list of `DriftStatus` items.
    drift_statuses: ?[]const DriftStatus,

    /// Filters enabled controls by their inheritance drift status, allowing you to
    /// find controls with specific inheritance-related drift conditions.
    inheritance_drift_statuses: ?[]const DriftStatus,

    /// Filters enabled controls by their parent control identifiers, allowing you
    /// to find child controls of specific parent controls.
    parent_identifiers: ?[]const []const u8,

    /// Filters enabled controls by their resource drift status, allowing you to
    /// find controls with specific resource-related drift conditions.
    resource_drift_statuses: ?[]const DriftStatus,

    /// A list of `EnablementStatus` items.
    statuses: ?[]const EnablementStatus,

    pub const json_field_names = .{
        .control_identifiers = "controlIdentifiers",
        .drift_statuses = "driftStatuses",
        .inheritance_drift_statuses = "inheritanceDriftStatuses",
        .parent_identifiers = "parentIdentifiers",
        .resource_drift_statuses = "resourceDriftStatuses",
        .statuses = "statuses",
    };
};

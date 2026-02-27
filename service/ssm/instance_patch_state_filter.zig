const InstancePatchStateOperatorType = @import("instance_patch_state_operator_type.zig").InstancePatchStateOperatorType;

/// Defines a filter used in DescribeInstancePatchStatesForPatchGroup to scope
/// down the information returned by the API.
///
/// **Example**: To filter for all managed nodes in a patch group
/// having more than three patches with a `FailedCount` status, use the
/// following for the
/// filter:
///
/// * Value for `Key`: `FailedCount`
///
/// * Value for `Type`: `GreaterThan`
///
/// * Value for `Values`: `3`
pub const InstancePatchStateFilter = struct {
    /// The key for the filter. Supported values include the following:
    ///
    /// * `InstalledCount`
    ///
    /// * `InstalledOtherCount`
    ///
    /// * `InstalledPendingRebootCount`
    ///
    /// * `InstalledRejectedCount`
    ///
    /// * `MissingCount`
    ///
    /// * `FailedCount`
    ///
    /// * `UnreportedNotApplicableCount`
    ///
    /// * `NotApplicableCount`
    key: []const u8,

    /// The type of comparison that should be performed for the value.
    type: InstancePatchStateOperatorType,

    /// The value for the filter. Must be an integer greater than or equal to 0.
    values: []const []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .type = "Type",
        .values = "Values",
    };
};

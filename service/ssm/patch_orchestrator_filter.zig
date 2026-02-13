/// Defines a filter used in Patch Manager APIs. Supported filter keys depend on
/// the API
/// operation that includes the filter. Patch Manager API operations that use
/// `PatchOrchestratorFilter` include the following:
///
/// * DescribeAvailablePatches
///
/// * DescribeInstancePatches
///
/// * DescribePatchBaselines
///
/// * DescribePatchGroups
pub const PatchOrchestratorFilter = struct {
    /// The key for the filter.
    key: ?[]const u8,

    /// The value for the filter.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .values = "Values",
    };
};

/// Specifies the scope of resources to record from a third-party cloud service
/// provider.
pub const ScopeConfiguration = struct {
    /// Specifies whether to record resources from all supported regions for the
    /// third-party cloud service provider.
    all_regions: bool = false,

    /// The list of regions from the third-party cloud service provider to include
    /// when recording resources. Used when `allRegions` is set to `false`.
    included_regions: ?[]const []const u8 = null,

    /// The type of scope for the third-party cloud resources. Valid values include
    /// `tenant` and `subscription`.
    scope_type: []const u8,

    /// The list of specific scope values for the third-party cloud resources. For
    /// example, a list of Azure subscriptions or management groups.
    scope_values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .all_regions = "allRegions",
        .included_regions = "includedRegions",
        .scope_type = "scopeType",
        .scope_values = "scopeValues",
    };
};

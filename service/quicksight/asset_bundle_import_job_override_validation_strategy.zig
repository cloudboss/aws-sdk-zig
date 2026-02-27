/// An optional parameter that overrides the validation strategy for all
/// analyses and
/// dashboards before the resource is imported.
pub const AssetBundleImportJobOverrideValidationStrategy = struct {
    /// A Boolean value that indicates whether to import all analyses and dashboards
    /// under
    /// strict or lenient mode.
    strict_mode_for_all_resources: bool = false,

    pub const json_field_names = .{
        .strict_mode_for_all_resources = "StrictModeForAllResources",
    };
};

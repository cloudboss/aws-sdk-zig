/// The option to relax the validation that is required to export each asset.
/// When
/// `StrictModeForAllResource` is set to `false`, validation is
/// skipped for specific UI errors.
pub const AssetBundleExportJobValidationStrategy = struct {
    /// A Boolean value that indicates whether to export resources under strict or
    /// lenient
    /// mode.
    strict_mode_for_all_resources: bool = false,

    pub const json_field_names = .{
        .strict_mode_for_all_resources = "StrictModeForAllResources",
    };
};

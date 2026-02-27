/// License asset group configuration.
pub const LicenseAssetGroupConfiguration = struct {
    /// License Asset Group Configuration Usage dimension.
    usage_dimension: ?[]const u8,

    pub const json_field_names = .{
        .usage_dimension = "UsageDimension",
    };
};

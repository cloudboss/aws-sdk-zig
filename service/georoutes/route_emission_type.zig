/// Type of the emission.
///
/// **Valid values**: `Euro1, Euro2, Euro3, Euro4, Euro5, Euro6, EuroEev`
pub const RouteEmissionType = struct {
    /// The CO 2 emission classes.
    co_2_emission_class: ?[]const u8,

    /// Type of the emission.
    ///
    /// **Valid values**: `Euro1, Euro2, Euro3, Euro4, Euro5, Euro6, EuroEev`
    @"type": []const u8,

    pub const json_field_names = .{
        .co_2_emission_class = "Co2EmissionClass",
        .@"type" = "Type",
    };
};

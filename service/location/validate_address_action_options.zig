const ValidateAddressAdditionalFeature = @import("validate_address_additional_feature.zig").ValidateAddressAdditionalFeature;

/// Options specific to address validation jobs.
pub const ValidateAddressActionOptions = struct {
    /// A list of optional additional parameters that can be requested for each
    /// result.
    ///
    /// Values:
    ///
    /// * `Position` - Return the position coordinates of the address if available.
    /// * `CountrySpecificAttributes` - Return additional information about the
    ///   address specific to the country of origin.
    additional_features: ?[]const ValidateAddressAdditionalFeature = null,

    pub const json_field_names = .{
        .additional_features = "AdditionalFeatures",
    };
};

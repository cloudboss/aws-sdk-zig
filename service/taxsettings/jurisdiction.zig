/// The jurisdiction details of the TRN information of the customers. This
/// doesn't contain
/// full legal address, and contains only country code and
/// state/region/province.
pub const Jurisdiction = struct {
    /// The country code of the jurisdiction.
    country_code: []const u8,

    /// The state, region, or province associated with the country of the
    /// jurisdiction, if
    /// applicable.
    state_or_region: ?[]const u8 = null,

    pub const json_field_names = .{
        .country_code = "countryCode",
        .state_or_region = "stateOrRegion",
    };
};

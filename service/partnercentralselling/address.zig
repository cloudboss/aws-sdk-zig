const CountryCode = @import("country_code.zig").CountryCode;

/// Specifies the end `Customer`'s address details associated with the
/// `Opportunity`.
pub const Address = struct {
    /// Specifies the end `Customer`'s city associated with the `Opportunity`.
    city: ?[]const u8,

    /// Specifies the end `Customer`'s country associated with the `Opportunity`.
    country_code: ?CountryCode,

    /// Specifies the end `Customer`'s postal code associated with the
    /// `Opportunity`.
    postal_code: ?[]const u8,

    /// Specifies the end `Customer`'s state or region associated with the
    /// `Opportunity`.
    ///
    /// Valid values: `Alabama | Alaska | American Samoa | Arizona | Arkansas |
    /// California | Colorado | Connecticut | Delaware | Dist. of Columbia |
    /// Federated States of Micronesia | Florida | Georgia | Guam | Hawaii | Idaho |
    /// Illinois | Indiana | Iowa | Kansas | Kentucky | Louisiana | Maine | Marshall
    /// Islands | Maryland | Massachusetts | Michigan | Minnesota | Mississippi |
    /// Missouri | Montana | Nebraska | Nevada | New Hampshire | New Jersey | New
    /// Mexico | New York | North Carolina | North Dakota | Northern Mariana Islands
    /// | Ohio | Oklahoma | Oregon | Palau | Pennsylvania | Puerto Rico | Rhode
    /// Island | South Carolina | South Dakota | Tennessee | Texas | Utah | Vermont
    /// | Virginia | Virgin Islands | Washington | West Virginia | Wisconsin |
    /// Wyoming | APO/AE | AFO/FPO | FPO, AP`
    state_or_region: ?[]const u8,

    /// Specifies the end `Customer`'s street address associated with the
    /// `Opportunity`.
    street_address: ?[]const u8,

    pub const json_field_names = .{
        .city = "City",
        .country_code = "CountryCode",
        .postal_code = "PostalCode",
        .state_or_region = "StateOrRegion",
        .street_address = "StreetAddress",
    };
};

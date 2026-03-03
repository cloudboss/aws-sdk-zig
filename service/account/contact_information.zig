/// Contains the details of the primary contact information associated with an
/// Amazon Web Services account.
pub const ContactInformation = struct {
    /// The first line of the primary contact address.
    address_line_1: []const u8,

    /// The second line of the primary contact address, if any.
    address_line_2: ?[]const u8 = null,

    /// The third line of the primary contact address, if any.
    address_line_3: ?[]const u8 = null,

    /// The city of the primary contact address.
    city: []const u8,

    /// The name of the company associated with the primary contact information, if
    /// any.
    company_name: ?[]const u8 = null,

    /// The ISO-3166 two-letter country code for the primary contact address.
    country_code: []const u8,

    /// The district or county of the primary contact address, if any.
    district_or_county: ?[]const u8 = null,

    /// The full name of the primary contact address.
    full_name: []const u8,

    /// The phone number of the primary contact information. The number will be
    /// validated and, in some countries, checked for activation.
    phone_number: []const u8,

    /// The postal code of the primary contact address.
    postal_code: []const u8,

    /// The state or region of the primary contact address. If the mailing address
    /// is within the United States (US), the value in this field can be either a
    /// two character state code (for example, `NJ`) or the full state name (for
    /// example, `New Jersey`). This field is required in the following countries:
    /// `US`, `CA`, `GB`, `DE`, `JP`, `IN`, and `BR`.
    state_or_region: ?[]const u8 = null,

    /// The URL of the website associated with the primary contact information, if
    /// any.
    website_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .address_line_1 = "AddressLine1",
        .address_line_2 = "AddressLine2",
        .address_line_3 = "AddressLine3",
        .city = "City",
        .company_name = "CompanyName",
        .country_code = "CountryCode",
        .district_or_county = "DistrictOrCounty",
        .full_name = "FullName",
        .phone_number = "PhoneNumber",
        .postal_code = "PostalCode",
        .state_or_region = "StateOrRegion",
        .website_url = "WebsiteUrl",
    };
};

/// The country and area code for a proxy phone number in a proxy phone session.
pub const GeoMatchParams = struct {
    /// The area code.
    area_code: []const u8,

    /// The country.
    country: []const u8,

    pub const json_field_names = .{
        .area_code = "AreaCode",
        .country = "Country",
    };
};

const PlaceGeometry = @import("place_geometry.zig").PlaceGeometry;
const TimeZone = @import("time_zone.zig").TimeZone;

/// Contains details about addresses or points of interest that match the search
/// criteria.
///
/// Not all details are included with all responses. Some details may only be
/// returned by specific data partners.
pub const Place = struct {
    /// The numerical portion of an address, such as a building number.
    address_number: ?[]const u8,

    /// The Amazon Location categories that describe this Place.
    ///
    /// For more information about using categories, including a list of Amazon
    /// Location categories, see [Categories and
    /// filtering](https://docs.aws.amazon.com/location/previous/developerguide/category-filtering.html), in the *Amazon Location Service developer guide*.
    categories: ?[]const []const u8,

    /// A country/region specified using [ISO
    /// 3166](https://www.iso.org/iso-3166-country-codes.html) 3-digit
    /// country/region code. For example, `CAN`.
    country: ?[]const u8,

    geometry: PlaceGeometry,

    /// `True` if the result is interpolated from other known places.
    ///
    /// `False` if the Place is a known place.
    ///
    /// Not returned when the partner does not provide the information.
    ///
    /// For example, returns `False` for an address location that is found in the
    /// partner data, but returns `True` if an address does not exist in the partner
    /// data and its location is calculated by interpolating between other known
    /// addresses.
    interpolated: ?bool,

    /// The full name and address of the point of interest such as a city, region,
    /// or country. For example, `123 Any Street, Any Town, USA`.
    label: ?[]const u8,

    /// A name for a local area, such as a city or town name. For example,
    /// `Toronto`.
    municipality: ?[]const u8,

    /// The name of a community district. For example, `Downtown`.
    neighborhood: ?[]const u8,

    /// A group of numbers and letters in a country-specific format, which
    /// accompanies the address for the purpose of identifying a location.
    postal_code: ?[]const u8,

    /// A name for an area or geographical division, such as a province or state
    /// name. For example, `British Columbia`.
    region: ?[]const u8,

    /// The name for a street or a road to identify a location. For example, `Main
    /// Street`.
    street: ?[]const u8,

    /// An area that's part of a larger municipality. For example, `Blissville ` is
    /// a submunicipality in the Queen County in New York.
    ///
    /// This property supported by Esri and OpenData. The Esri property is
    /// `district`, and the OpenData property is `borough`.
    sub_municipality: ?[]const u8,

    /// A county, or an area that's part of a larger region. For example, `Metro
    /// Vancouver`.
    sub_region: ?[]const u8,

    /// Categories from the data provider that describe the Place that are not
    /// mapped to any Amazon Location categories.
    supplemental_categories: ?[]const []const u8,

    /// The time zone in which the `Place` is located. Returned only when using HERE
    /// or Grab as the selected partner.
    time_zone: ?TimeZone,

    /// For addresses with multiple units, the unit identifier. Can include numbers
    /// and letters, for example `3B` or `Unit 123`.
    ///
    /// Returned only for a place index that uses Esri or Grab as a data provider.
    /// Is not returned for `SearchPlaceIndexForPosition`.
    unit_number: ?[]const u8,

    /// For addresses with a `UnitNumber`, the type of unit. For example,
    /// `Apartment`.
    ///
    /// Returned only for a place index that uses Esri as a data provider.
    unit_type: ?[]const u8,

    pub const json_field_names = .{
        .address_number = "AddressNumber",
        .categories = "Categories",
        .country = "Country",
        .geometry = "Geometry",
        .interpolated = "Interpolated",
        .label = "Label",
        .municipality = "Municipality",
        .neighborhood = "Neighborhood",
        .postal_code = "PostalCode",
        .region = "Region",
        .street = "Street",
        .sub_municipality = "SubMunicipality",
        .sub_region = "SubRegion",
        .supplemental_categories = "SupplementalCategories",
        .time_zone = "TimeZone",
        .unit_number = "UnitNumber",
        .unit_type = "UnitType",
    };
};

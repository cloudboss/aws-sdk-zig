/// The impacted location, such as a city, that Amazon Web Services clients
/// access application resources from.
pub const ClientLocation = struct {
    /// The name of the internet service provider (ISP) or network (ASN).
    as_name: []const u8,

    /// The Autonomous System Number (ASN) of the network at an impacted location.
    as_number: i64,

    /// The name of the city where the internet event is located.
    city: []const u8,

    /// The name of the country where the internet event is located.
    country: []const u8,

    /// The latitude where the internet event is located.
    latitude: f64,

    /// The longitude where the internet event is located.
    longitude: f64,

    /// The metro area where the health event is located.
    ///
    /// Metro indicates a metropolitan region in the United States, such as the
    /// region around New York City. In non-US countries,
    /// this is a second-level subdivision. For example, in the United Kingdom, it
    /// could be a county, a London borough, a unitary
    /// authority, council area, and so on.
    metro: ?[]const u8,

    /// The subdivision location where the health event is located. The subdivision
    /// usually maps to states in most countries
    /// (including the United States). For United Kingdom, it maps to a country
    /// (England, Scotland, Wales) or province (Northern Ireland).
    subdivision: ?[]const u8,

    pub const json_field_names = .{
        .as_name = "ASName",
        .as_number = "ASNumber",
        .city = "City",
        .country = "Country",
        .latitude = "Latitude",
        .longitude = "Longitude",
        .metro = "Metro",
        .subdivision = "Subdivision",
    };
};

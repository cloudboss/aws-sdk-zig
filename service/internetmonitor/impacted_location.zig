const NetworkImpairment = @import("network_impairment.zig").NetworkImpairment;
const InternetHealth = @import("internet_health.zig").InternetHealth;
const HealthEventStatus = @import("health_event_status.zig").HealthEventStatus;

/// Information about a location impacted by a health event in Amazon CloudWatch
/// Internet Monitor.
///
/// Geographic regions are hierarchically categorized into country, subdivision,
/// metro and city geographic granularities. The geographic region is identified
/// based
/// on the IP address used at the client locations.
pub const ImpactedLocation = struct {
    /// The name of the internet service provider (ISP) or network (ASN).
    as_name: []const u8,

    /// The Autonomous System Number (ASN) of the network at an impacted location.
    as_number: i64,

    /// The cause of the impairment. There are two types of network impairments:
    /// Amazon Web Services network issues
    /// or internet issues. Internet issues are typically a problem with a network
    /// provider, like an internet service provider (ISP).
    caused_by: ?NetworkImpairment = null,

    /// The name of the city where the health event is located.
    city: ?[]const u8 = null,

    /// The name of the country where the health event is located.
    country: []const u8,

    /// The country code where the health event is located. The ISO 3166-2 codes for
    /// the
    /// country is provided, when available.
    country_code: ?[]const u8 = null,

    /// The calculated health at a specific location.
    internet_health: ?InternetHealth = null,

    /// The IPv4 prefixes at the client location that was impacted by the health
    /// event.
    ipv_4_prefixes: ?[]const []const u8 = null,

    /// The latitude where the health event is located.
    latitude: ?f64 = null,

    /// The longitude where the health event is located.
    longitude: ?f64 = null,

    /// The metro area where the health event is located.
    ///
    /// Metro indicates a metropolitan region in the United States, such as the
    /// region around New York City.
    /// In non-US countries, this is a second-level subdivision. For example, in the
    /// United Kingdom, it could be
    /// a county, a London borough, a unitary authority, council area, and so on.
    metro: ?[]const u8 = null,

    /// The service location where the health event is located.
    service_location: ?[]const u8 = null,

    /// The status of the health event at an impacted location.
    status: HealthEventStatus,

    /// The subdivision location where the health event is located. The subdivision
    /// usually maps to
    /// states in most countries (including the United States). For United Kingdom,
    /// it maps to a country (England,
    /// Scotland, Wales) or province (Northern Ireland).
    subdivision: ?[]const u8 = null,

    /// The subdivision code where the health event is located. The ISO 3166-2 codes
    /// for
    /// country subdivisions is provided, when available.
    subdivision_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .as_name = "ASName",
        .as_number = "ASNumber",
        .caused_by = "CausedBy",
        .city = "City",
        .country = "Country",
        .country_code = "CountryCode",
        .internet_health = "InternetHealth",
        .ipv_4_prefixes = "Ipv4Prefixes",
        .latitude = "Latitude",
        .longitude = "Longitude",
        .metro = "Metro",
        .service_location = "ServiceLocation",
        .status = "Status",
        .subdivision = "Subdivision",
        .subdivision_code = "SubdivisionCode",
    };
};

const IpCity = @import("ip_city.zig").IpCity;
const IpCountry = @import("ip_country.zig").IpCountry;
const IpGeoLocation = @import("ip_geo_location.zig").IpGeoLocation;
const IpOwner = @import("ip_owner.zig").IpOwner;

/// Provides information about the IP address of the device that an entity used
/// to perform an action on an affected resource.
pub const IpAddressDetails = struct {
    /// The Internet Protocol version 4 (IPv4) address of the device.
    ip_address_v4: ?[]const u8 = null,

    /// The city that the IP address originated from.
    ip_city: ?IpCity = null,

    /// The country that the IP address originated from.
    ip_country: ?IpCountry = null,

    /// The geographic coordinates of the location that the IP address originated
    /// from.
    ip_geo_location: ?IpGeoLocation = null,

    /// The registered owner of the IP address.
    ip_owner: ?IpOwner = null,

    pub const json_field_names = .{
        .ip_address_v4 = "ipAddressV4",
        .ip_city = "ipCity",
        .ip_country = "ipCountry",
        .ip_geo_location = "ipGeoLocation",
        .ip_owner = "ipOwner",
    };
};

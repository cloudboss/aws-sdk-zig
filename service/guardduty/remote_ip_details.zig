const City = @import("city.zig").City;
const Country = @import("country.zig").Country;
const GeoLocation = @import("geo_location.zig").GeoLocation;
const Organization = @import("organization.zig").Organization;

/// Contains information about the remote IP address of the connection.
pub const RemoteIpDetails = struct {
    /// The city information of the remote IP address.
    city: ?City = null,

    /// The country code of the remote IP address.
    country: ?Country = null,

    /// The location information of the remote IP address.
    geo_location: ?GeoLocation = null,

    /// The IPv4 remote address of the connection.
    ip_address_v4: ?[]const u8 = null,

    /// The IPv6 remote address of the connection.
    ip_address_v6: ?[]const u8 = null,

    /// The ISP organization information of the remote IP address.
    organization: ?Organization = null,

    pub const json_field_names = .{
        .city = "City",
        .country = "Country",
        .geo_location = "GeoLocation",
        .ip_address_v4 = "IpAddressV4",
        .ip_address_v6 = "IpAddressV6",
        .organization = "Organization",
    };
};

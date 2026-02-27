const City = @import("city.zig").City;
const Country = @import("country.zig").Country;
const GeoLocation = @import("geo_location.zig").GeoLocation;
const IpOrganizationDetails = @import("ip_organization_details.zig").IpOrganizationDetails;

/// For `AwsApiAction`, `NetworkConnectionAction`, and
/// `PortProbeAction`, `RemoteIpDetails` provides information about
/// the remote IP address that was involved in the action.
pub const ActionRemoteIpDetails = struct {
    /// The city where the remote IP address is located.
    city: ?City,

    /// The country where the remote IP address is located.
    country: ?Country,

    /// The coordinates of the location of the remote IP address.
    geo_location: ?GeoLocation,

    /// The IP address.
    ip_address_v4: ?[]const u8,

    /// The internet service provider (ISP) organization associated with the remote
    /// IP
    /// address.
    organization: ?IpOrganizationDetails,

    pub const json_field_names = .{
        .city = "City",
        .country = "Country",
        .geo_location = "GeoLocation",
        .ip_address_v4 = "IpAddressV4",
        .organization = "Organization",
    };
};

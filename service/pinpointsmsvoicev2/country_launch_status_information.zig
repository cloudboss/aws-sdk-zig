const CarrierStatusInformation = @import("carrier_status_information.zig").CarrierStatusInformation;
const CountryLaunchStatus = @import("country_launch_status.zig").CountryLaunchStatus;

/// Contains per-country launch status details for an RCS agent.
pub const CountryLaunchStatusInformation = struct {
    /// An array of CarrierStatusInformation objects containing carrier-level launch
    /// status details.
    carrier_status: []const CarrierStatusInformation,

    /// The two-character code, in ISO 3166-1 alpha-2 format, for the country or
    /// region.
    iso_country_code: []const u8,

    /// The RCS platform identifier for this country.
    rcs_platform_id: ?[]const u8 = null,

    /// The unique identifier of the registration associated with this country
    /// launch.
    registration_id: []const u8,

    /// The launch status for this country.
    status: CountryLaunchStatus,

    pub const json_field_names = .{
        .carrier_status = "CarrierStatus",
        .iso_country_code = "IsoCountryCode",
        .rcs_platform_id = "RcsPlatformId",
        .registration_id = "RegistrationId",
        .status = "Status",
    };
};

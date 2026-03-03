const NumberCapability = @import("number_capability.zig").NumberCapability;
const RouteType = @import("route_type.zig").RouteType;

/// A list of phone numbers and their metadata.
pub const PhoneNumberInformation = struct {
    /// The date and time when the phone number was created.
    created_at: ?i64 = null,

    /// The two-character code for the country or region, in ISO 3166-1 alpha-2
    /// format.
    iso_2_country_code: ?[]const u8 = null,

    /// The capabilities of each phone number.
    number_capabilities: ?[]const NumberCapability = null,

    /// The phone number.
    phone_number: ?[]const u8 = null,

    /// The list of supported routes.
    route_type: ?RouteType = null,

    /// The status of the phone number.
    status: ?[]const u8 = null,
};

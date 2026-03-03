const aws = @import("aws");

const OfferingDurationUnits = @import("offering_duration_units.zig").OfferingDurationUnits;
const OfferingType = @import("offering_type.zig").OfferingType;
const RenewalSettings = @import("renewal_settings.zig").RenewalSettings;
const ReservationResourceSpecification = @import("reservation_resource_specification.zig").ReservationResourceSpecification;
const ReservationState = @import("reservation_state.zig").ReservationState;

/// Reserved resources available to use
pub const Reservation = struct {
    /// Unique reservation ARN, e.g.
    /// 'arn:aws:medialive:us-west-2:123456789012:reservation:1234567'
    arn: ?[]const u8 = null,

    /// Number of reserved resources
    count: ?i32 = null,

    /// Currency code for usagePrice and fixedPrice in ISO-4217 format, e.g. 'USD'
    currency_code: ?[]const u8 = null,

    /// Lease duration, e.g. '12'
    duration: ?i32 = null,

    /// Units for duration, e.g. 'MONTHS'
    duration_units: ?OfferingDurationUnits = null,

    /// Reservation UTC end date and time in ISO-8601 format, e.g.
    /// '2019-03-01T00:00:00'
    end: ?[]const u8 = null,

    /// One-time charge for each reserved resource, e.g. '0.0' for a NO_UPFRONT
    /// offering
    fixed_price: ?f64 = null,

    /// User specified reservation name
    name: ?[]const u8 = null,

    /// Offering description, e.g. 'HD AVC output at 10-20 Mbps, 30 fps, and
    /// standard VQ in US West (Oregon)'
    offering_description: ?[]const u8 = null,

    /// Unique offering ID, e.g. '87654321'
    offering_id: ?[]const u8 = null,

    /// Offering type, e.g. 'NO_UPFRONT'
    offering_type: ?OfferingType = null,

    /// AWS region, e.g. 'us-west-2'
    region: ?[]const u8 = null,

    /// Renewal settings for the reservation
    renewal_settings: ?RenewalSettings = null,

    /// Unique reservation ID, e.g. '1234567'
    reservation_id: ?[]const u8 = null,

    /// Resource configuration details
    resource_specification: ?ReservationResourceSpecification = null,

    /// Reservation UTC start date and time in ISO-8601 format, e.g.
    /// '2018-03-01T00:00:00'
    start: ?[]const u8 = null,

    /// Current state of reservation, e.g. 'ACTIVE'
    state: ?ReservationState = null,

    /// A collection of key-value pairs
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Recurring usage charge for each reserved resource, e.g. '157.0'
    usage_price: ?f64 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .count = "Count",
        .currency_code = "CurrencyCode",
        .duration = "Duration",
        .duration_units = "DurationUnits",
        .end = "End",
        .fixed_price = "FixedPrice",
        .name = "Name",
        .offering_description = "OfferingDescription",
        .offering_id = "OfferingId",
        .offering_type = "OfferingType",
        .region = "Region",
        .renewal_settings = "RenewalSettings",
        .reservation_id = "ReservationId",
        .resource_specification = "ResourceSpecification",
        .start = "Start",
        .state = "State",
        .tags = "Tags",
        .usage_price = "UsagePrice",
    };
};

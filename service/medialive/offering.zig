const OfferingDurationUnits = @import("offering_duration_units.zig").OfferingDurationUnits;
const OfferingType = @import("offering_type.zig").OfferingType;
const ReservationResourceSpecification = @import("reservation_resource_specification.zig").ReservationResourceSpecification;

/// Reserved resources available for purchase
pub const Offering = struct {
    /// Unique offering ARN, e.g.
    /// 'arn:aws:medialive:us-west-2:123456789012:offering:87654321'
    arn: ?[]const u8,

    /// Currency code for usagePrice and fixedPrice in ISO-4217 format, e.g. 'USD'
    currency_code: ?[]const u8,

    /// Lease duration, e.g. '12'
    duration: ?i32,

    /// Units for duration, e.g. 'MONTHS'
    duration_units: ?OfferingDurationUnits,

    /// One-time charge for each reserved resource, e.g. '0.0' for a NO_UPFRONT
    /// offering
    fixed_price: ?f64,

    /// Offering description, e.g. 'HD AVC output at 10-20 Mbps, 30 fps, and
    /// standard VQ in US West (Oregon)'
    offering_description: ?[]const u8,

    /// Unique offering ID, e.g. '87654321'
    offering_id: ?[]const u8,

    /// Offering type, e.g. 'NO_UPFRONT'
    offering_type: ?OfferingType,

    /// AWS region, e.g. 'us-west-2'
    region: ?[]const u8,

    /// Resource configuration details
    resource_specification: ?ReservationResourceSpecification,

    /// Recurring usage charge for each reserved resource, e.g. '157.0'
    usage_price: ?f64,

    pub const json_field_names = .{
        .arn = "Arn",
        .currency_code = "CurrencyCode",
        .duration = "Duration",
        .duration_units = "DurationUnits",
        .fixed_price = "FixedPrice",
        .offering_description = "OfferingDescription",
        .offering_id = "OfferingId",
        .offering_type = "OfferingType",
        .region = "Region",
        .resource_specification = "ResourceSpecification",
        .usage_price = "UsagePrice",
    };
};

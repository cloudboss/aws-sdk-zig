const DurationUnits = @import("duration_units.zig").DurationUnits;
const PriceUnits = @import("price_units.zig").PriceUnits;
const ReservationState = @import("reservation_state.zig").ReservationState;
const ResourceSpecification = @import("resource_specification.zig").ResourceSpecification;

/// A pricing agreement for a discounted rate for a specific outbound bandwidth
/// that your MediaConnect account will use each month over a specific time
/// period. The discounted rate in the reservation applies to outbound bandwidth
/// for all flows from your account until your account reaches the amount of
/// bandwidth in your reservation. If you use more outbound bandwidth than the
/// agreed upon amount in a single month, the overage is charged at the
/// on-demand rate.
pub const Reservation = struct {
    /// The type of currency that is used for billing. The currencyCode used for
    /// your reservation is US dollars.
    currency_code: []const u8,

    /// The length of time that this reservation is active. MediaConnect defines
    /// this value in the offering.
    duration: i32,

    /// The unit of measurement for the duration of the reservation. MediaConnect
    /// defines this value in the offering.
    duration_units: DurationUnits,

    /// The day and time that this reservation expires. This value is calculated
    /// based on the start date and time that you set and the offering's duration.
    end: []const u8,

    /// The Amazon Resource Name (ARN) that MediaConnect assigns to the offering.
    offering_arn: []const u8,

    /// A description of the offering. MediaConnect defines this value in the
    /// offering.
    offering_description: []const u8,

    /// The cost of a single unit. This value, in combination with priceUnits, makes
    /// up the rate. MediaConnect defines this value in the offering.
    price_per_unit: []const u8,

    /// The unit of measurement that is used for billing. This value, in combination
    /// with pricePerUnit, makes up the rate. MediaConnect defines this value in the
    /// offering.
    price_units: PriceUnits,

    /// The Amazon Resource Name (ARN) that MediaConnect assigns to the reservation
    /// when you purchase an offering.
    reservation_arn: []const u8,

    /// The name that you assigned to the reservation when you purchased the
    /// offering.
    reservation_name: []const u8,

    /// The status of your reservation.
    reservation_state: ReservationState,

    /// A definition of the amount of outbound bandwidth that you would be reserving
    /// if you purchase the offering. MediaConnect defines the values that make up
    /// the resourceSpecification in the offering.
    resource_specification: ResourceSpecification,

    /// The day and time that the reservation becomes active. You set this value
    /// when you purchase the offering.
    start: []const u8,

    pub const json_field_names = .{
        .currency_code = "CurrencyCode",
        .duration = "Duration",
        .duration_units = "DurationUnits",
        .end = "End",
        .offering_arn = "OfferingArn",
        .offering_description = "OfferingDescription",
        .price_per_unit = "PricePerUnit",
        .price_units = "PriceUnits",
        .reservation_arn = "ReservationArn",
        .reservation_name = "ReservationName",
        .reservation_state = "ReservationState",
        .resource_specification = "ResourceSpecification",
        .start = "Start",
    };
};

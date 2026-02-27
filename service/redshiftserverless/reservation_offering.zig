const OfferingType = @import("offering_type.zig").OfferingType;

/// The class of offering for the reservation. The offering class determines the
/// payment schedule for the reservation.
pub const ReservationOffering = struct {
    /// The currency code for the offering.
    currency_code: ?[]const u8,

    /// The duration, in seconds, for which the reservation reserves the RPUs.
    duration: i32 = 0,

    /// The rate you are charged for each hour the reservation is active.
    hourly_charge: f64 = 0,

    /// The offering identifier.
    offering_id: ?[]const u8,

    /// Determines the payment schedule for the reservation.
    offering_type: ?OfferingType,

    /// The up-front price you are charged for the reservation.
    upfront_charge: f64 = 0,

    pub const json_field_names = .{
        .currency_code = "currencyCode",
        .duration = "duration",
        .hourly_charge = "hourlyCharge",
        .offering_id = "offeringId",
        .offering_type = "offeringType",
        .upfront_charge = "upfrontCharge",
    };
};

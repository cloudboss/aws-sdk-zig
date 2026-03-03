const ReservationOffering = @import("reservation_offering.zig").ReservationOffering;

/// Represents an Amazon Redshift Serverless reservation, which gives you the
/// option to commit to a specified number of Redshift Processing Units (RPUs)
/// for a year at a discount from Serverless on-demand (OD) rates.
pub const Reservation = struct {
    /// The number of Redshift Processing Units (RPUs) to reserve.
    capacity: i32 = 0,

    /// The end date for the serverless reservation. This date is one year after the
    /// start date that you specify.
    end_date: ?i64 = null,

    /// The type of offering for the reservation. The offering class determines the
    /// payment schedule for the reservation.
    offering: ?ReservationOffering = null,

    /// The Amazon Resource Name (ARN) that uniquely identifies the serverless
    /// reservation.
    reservation_arn: ?[]const u8 = null,

    /// The identifier that uniquely identifies the serverless reservation.
    reservation_id: ?[]const u8 = null,

    /// The start date for the serverless reservation. This is the date you created
    /// the reservation.
    start_date: ?i64 = null,

    /// The status of the reservation. Possible values include the following:
    ///
    /// * `payment-pending`
    /// * `active`
    /// * `payment-failed`
    /// * `retired`
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .capacity = "capacity",
        .end_date = "endDate",
        .offering = "offering",
        .reservation_arn = "reservationArn",
        .reservation_id = "reservationId",
        .start_date = "startDate",
        .status = "status",
    };
};

const ReservationDetails = @import("reservation_details.zig").ReservationDetails;
const ReservationType = @import("reservation_type.zig").ReservationType;

/// Item in a list of ground station reservations.
pub const GroundStationReservationListItem = struct {
    /// Name of an antenna.
    antenna_name: []const u8,

    /// End time of a ground station reservation in UTC.
    end_time: i64,

    /// ID of a ground station.
    ground_station_id: []const u8,

    /// Details of a ground station reservation.
    reservation_details: ReservationDetails,

    /// Type of a ground station reservation.
    reservation_type: ReservationType,

    /// Start time of a ground station reservation in UTC.
    start_time: i64,

    pub const json_field_names = .{
        .antenna_name = "antennaName",
        .end_time = "endTime",
        .ground_station_id = "groundStationId",
        .reservation_details = "reservationDetails",
        .reservation_type = "reservationType",
        .start_time = "startTime",
    };
};

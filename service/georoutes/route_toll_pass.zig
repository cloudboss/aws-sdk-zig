const RouteTollPassValidityPeriod = @import("route_toll_pass_validity_period.zig").RouteTollPassValidityPeriod;

/// Details if the toll rate can be a pass that supports multiple trips.
pub const RouteTollPass = struct {
    /// If the pass includes the rate for the return leg of the trip.
    includes_return_trip: ?bool = null,

    /// If the pass is only valid for senior persons.
    senior_pass: ?bool = null,

    /// If the toll pass can be transferred, and how many times.
    transfer_count: ?i32 = null,

    /// Number of trips the pass is valid for.
    trip_count: ?i32 = null,

    /// Period for which the pass is valid.
    validity_period: ?RouteTollPassValidityPeriod = null,

    pub const json_field_names = .{
        .includes_return_trip = "IncludesReturnTrip",
        .senior_pass = "SeniorPass",
        .transfer_count = "TransferCount",
        .trip_count = "TripCount",
        .validity_period = "ValidityPeriod",
    };
};

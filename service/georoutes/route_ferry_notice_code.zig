pub const RouteFerryNoticeCode = enum {
    accurate_polyline_unavailable,
    no_schedule,
    other,
    violated_avoid_ferry,
    violated_avoid_rail_ferry,
    seasonal_closure,
    potential_violated_vehicle_restriction_usage,

    pub const json_field_names = .{
        .accurate_polyline_unavailable = "ACCURATE_POLYLINE_UNAVAILABLE",
        .no_schedule = "NO_SCHEDULE",
        .other = "OTHER",
        .violated_avoid_ferry = "VIOLATED_AVOID_FERRY",
        .violated_avoid_rail_ferry = "VIOLATED_AVOID_RAIL_FERRY",
        .seasonal_closure = "SEASONAL_CLOSURE",
        .potential_violated_vehicle_restriction_usage = "POTENTIAL_VIOLATED_VEHICLE_RESTRICTION_USAGE",
    };
};

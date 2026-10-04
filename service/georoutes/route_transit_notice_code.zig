const std = @import("std");

pub const RouteTransitNoticeCode = enum {
    accurate_polyline_unavailable,
    intermediate_stops_unavailable,
    no_schedule,
    other,
    potential_violated_vehicle_restriction_usage,
    scheduled_times,
    seasonal_closure,
    violated_avoid_ferry,
    violated_avoid_rail_ferry,
    violated_excluded_transit_mode,
    violated_vehicle_restriction,
    violated_avoid_areas,

    pub const json_field_names = .{
        .accurate_polyline_unavailable = "AccuratePolylineUnavailable",
        .intermediate_stops_unavailable = "IntermediateStopsUnavailable",
        .no_schedule = "NoSchedule",
        .other = "Other",
        .potential_violated_vehicle_restriction_usage = "PotentialViolatedVehicleRestrictionUsage",
        .scheduled_times = "ScheduledTimes",
        .seasonal_closure = "SeasonalClosure",
        .violated_avoid_ferry = "ViolatedAvoidFerry",
        .violated_avoid_rail_ferry = "ViolatedAvoidRailFerry",
        .violated_excluded_transit_mode = "ViolatedExcludedTransitMode",
        .violated_vehicle_restriction = "ViolatedVehicleRestriction",
        .violated_avoid_areas = "ViolatedAvoidAreas",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .accurate_polyline_unavailable => "AccuratePolylineUnavailable",
            .intermediate_stops_unavailable => "IntermediateStopsUnavailable",
            .no_schedule => "NoSchedule",
            .other => "Other",
            .potential_violated_vehicle_restriction_usage => "PotentialViolatedVehicleRestrictionUsage",
            .scheduled_times => "ScheduledTimes",
            .seasonal_closure => "SeasonalClosure",
            .violated_avoid_ferry => "ViolatedAvoidFerry",
            .violated_avoid_rail_ferry => "ViolatedAvoidRailFerry",
            .violated_excluded_transit_mode => "ViolatedExcludedTransitMode",
            .violated_vehicle_restriction => "ViolatedVehicleRestriction",
            .violated_avoid_areas => "ViolatedAvoidAreas",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};

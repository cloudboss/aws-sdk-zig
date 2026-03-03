const std = @import("std");

pub const RouteFerryNoticeCode = enum {
    accurate_polyline_unavailable,
    no_schedule,
    other,
    violated_avoid_ferry,
    violated_avoid_rail_ferry,
    seasonal_closure,
    potential_violated_vehicle_restriction_usage,

    pub const json_field_names = .{
        .accurate_polyline_unavailable = "AccuratePolylineUnavailable",
        .no_schedule = "NoSchedule",
        .other = "Other",
        .violated_avoid_ferry = "ViolatedAvoidFerry",
        .violated_avoid_rail_ferry = "ViolatedAvoidRailFerry",
        .seasonal_closure = "SeasonalClosure",
        .potential_violated_vehicle_restriction_usage = "PotentialViolatedVehicleRestrictionUsage",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .accurate_polyline_unavailable => "AccuratePolylineUnavailable",
            .no_schedule => "NoSchedule",
            .other => "Other",
            .violated_avoid_ferry => "ViolatedAvoidFerry",
            .violated_avoid_rail_ferry => "ViolatedAvoidRailFerry",
            .seasonal_closure => "SeasonalClosure",
            .potential_violated_vehicle_restriction_usage => "PotentialViolatedVehicleRestrictionUsage",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};

const std = @import("std");

pub const RouteVehicleNoticeCode = enum {
    accurate_polyline_unavailable,
    other,
    potential_violated_avoid_toll_road_usage,
    potential_violated_carpool_usage,
    potential_violated_turn_restriction_usage,
    potential_violated_vehicle_restriction_usage,
    potential_violated_zone_restriction_usage,
    seasonal_closure,
    tolls_data_temporarily_unavailable,
    tolls_data_unavailable,
    toll_transponder,
    violated_avoid_controlled_access_highway,
    violated_avoid_difficult_turns,
    violated_avoid_dirt_road,
    violated_avoid_seasonal_closure,
    violated_avoid_toll_road,
    violated_avoid_toll_transponder,
    violated_avoid_truck_road_type,
    violated_avoid_tunnel,
    violated_avoid_u_turns,
    violated_blocked_road,
    violated_carpool,
    violated_emergency_gate,
    violated_start_direction,
    violated_turn_restriction,
    violated_vehicle_restriction,
    violated_zone_restriction,

    pub const json_field_names = .{
        .accurate_polyline_unavailable = "AccuratePolylineUnavailable",
        .other = "Other",
        .potential_violated_avoid_toll_road_usage = "PotentialViolatedAvoidTollRoadUsage",
        .potential_violated_carpool_usage = "PotentialViolatedCarpoolUsage",
        .potential_violated_turn_restriction_usage = "PotentialViolatedTurnRestrictionUsage",
        .potential_violated_vehicle_restriction_usage = "PotentialViolatedVehicleRestrictionUsage",
        .potential_violated_zone_restriction_usage = "PotentialViolatedZoneRestrictionUsage",
        .seasonal_closure = "SeasonalClosure",
        .tolls_data_temporarily_unavailable = "TollsDataTemporarilyUnavailable",
        .tolls_data_unavailable = "TollsDataUnavailable",
        .toll_transponder = "TollTransponder",
        .violated_avoid_controlled_access_highway = "ViolatedAvoidControlledAccessHighway",
        .violated_avoid_difficult_turns = "ViolatedAvoidDifficultTurns",
        .violated_avoid_dirt_road = "ViolatedAvoidDirtRoad",
        .violated_avoid_seasonal_closure = "ViolatedAvoidSeasonalClosure",
        .violated_avoid_toll_road = "ViolatedAvoidTollRoad",
        .violated_avoid_toll_transponder = "ViolatedAvoidTollTransponder",
        .violated_avoid_truck_road_type = "ViolatedAvoidTruckRoadType",
        .violated_avoid_tunnel = "ViolatedAvoidTunnel",
        .violated_avoid_u_turns = "ViolatedAvoidUTurns",
        .violated_blocked_road = "ViolatedBlockedRoad",
        .violated_carpool = "ViolatedCarpool",
        .violated_emergency_gate = "ViolatedEmergencyGate",
        .violated_start_direction = "ViolatedStartDirection",
        .violated_turn_restriction = "ViolatedTurnRestriction",
        .violated_vehicle_restriction = "ViolatedVehicleRestriction",
        .violated_zone_restriction = "ViolatedZoneRestriction",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .accurate_polyline_unavailable => "AccuratePolylineUnavailable",
            .other => "Other",
            .potential_violated_avoid_toll_road_usage => "PotentialViolatedAvoidTollRoadUsage",
            .potential_violated_carpool_usage => "PotentialViolatedCarpoolUsage",
            .potential_violated_turn_restriction_usage => "PotentialViolatedTurnRestrictionUsage",
            .potential_violated_vehicle_restriction_usage => "PotentialViolatedVehicleRestrictionUsage",
            .potential_violated_zone_restriction_usage => "PotentialViolatedZoneRestrictionUsage",
            .seasonal_closure => "SeasonalClosure",
            .tolls_data_temporarily_unavailable => "TollsDataTemporarilyUnavailable",
            .tolls_data_unavailable => "TollsDataUnavailable",
            .toll_transponder => "TollTransponder",
            .violated_avoid_controlled_access_highway => "ViolatedAvoidControlledAccessHighway",
            .violated_avoid_difficult_turns => "ViolatedAvoidDifficultTurns",
            .violated_avoid_dirt_road => "ViolatedAvoidDirtRoad",
            .violated_avoid_seasonal_closure => "ViolatedAvoidSeasonalClosure",
            .violated_avoid_toll_road => "ViolatedAvoidTollRoad",
            .violated_avoid_toll_transponder => "ViolatedAvoidTollTransponder",
            .violated_avoid_truck_road_type => "ViolatedAvoidTruckRoadType",
            .violated_avoid_tunnel => "ViolatedAvoidTunnel",
            .violated_avoid_u_turns => "ViolatedAvoidUTurns",
            .violated_blocked_road => "ViolatedBlockedRoad",
            .violated_carpool => "ViolatedCarpool",
            .violated_emergency_gate => "ViolatedEmergencyGate",
            .violated_start_direction => "ViolatedStartDirection",
            .violated_turn_restriction => "ViolatedTurnRestriction",
            .violated_vehicle_restriction => "ViolatedVehicleRestriction",
            .violated_zone_restriction => "ViolatedZoneRestriction",
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

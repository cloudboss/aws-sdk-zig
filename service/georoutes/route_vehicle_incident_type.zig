const std = @import("std");

pub const RouteVehicleIncidentType = enum {
    accident,
    congestion,
    construction,
    disabled_vehicle,
    lane_restriction,
    mass_transit,
    other,
    planned_event,
    road_closure,
    road_hazard,
    weather,

    pub const json_field_names = .{
        .accident = "Accident",
        .congestion = "Congestion",
        .construction = "Construction",
        .disabled_vehicle = "DisabledVehicle",
        .lane_restriction = "LaneRestriction",
        .mass_transit = "MassTransit",
        .other = "Other",
        .planned_event = "PlannedEvent",
        .road_closure = "RoadClosure",
        .road_hazard = "RoadHazard",
        .weather = "Weather",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .accident => "Accident",
            .congestion => "Congestion",
            .construction => "Construction",
            .disabled_vehicle => "DisabledVehicle",
            .lane_restriction => "LaneRestriction",
            .mass_transit => "MassTransit",
            .other => "Other",
            .planned_event => "PlannedEvent",
            .road_closure => "RoadClosure",
            .road_hazard => "RoadHazard",
            .weather => "Weather",
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

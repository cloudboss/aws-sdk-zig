const std = @import("std");

pub const RouteLegAdditionalFeature = enum {
    elevation,
    incidents,
    pass_through_waypoints,
    summary,
    tolls,
    travel_step_instructions,
    truck_road_types,
    typical_duration,
    zones,

    pub const json_field_names = .{
        .elevation = "Elevation",
        .incidents = "Incidents",
        .pass_through_waypoints = "PassThroughWaypoints",
        .summary = "Summary",
        .tolls = "Tolls",
        .travel_step_instructions = "TravelStepInstructions",
        .truck_road_types = "TruckRoadTypes",
        .typical_duration = "TypicalDuration",
        .zones = "Zones",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .elevation => "Elevation",
            .incidents => "Incidents",
            .pass_through_waypoints => "PassThroughWaypoints",
            .summary => "Summary",
            .tolls => "Tolls",
            .travel_step_instructions => "TravelStepInstructions",
            .truck_road_types => "TruckRoadTypes",
            .typical_duration => "TypicalDuration",
            .zones => "Zones",
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

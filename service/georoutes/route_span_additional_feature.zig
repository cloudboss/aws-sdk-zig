const std = @import("std");

pub const RouteSpanAdditionalFeature = enum {
    best_case_duration,
    car_access,
    country,
    distance,
    duration,
    dynamic_speed,
    functional_classification,
    gates,
    incidents,
    names,
    notices,
    pedestrian_access,
    railway_crossings,
    region,
    road_attributes,
    route_numbers,
    scooter_access,
    speed_limit,
    toll_systems,
    truck_access,
    truck_road_types,
    typical_duration,
    zones,
    consumption,

    pub const json_field_names = .{
        .best_case_duration = "BestCaseDuration",
        .car_access = "CarAccess",
        .country = "Country",
        .distance = "Distance",
        .duration = "Duration",
        .dynamic_speed = "DynamicSpeed",
        .functional_classification = "FunctionalClassification",
        .gates = "Gates",
        .incidents = "Incidents",
        .names = "Names",
        .notices = "Notices",
        .pedestrian_access = "PedestrianAccess",
        .railway_crossings = "RailwayCrossings",
        .region = "Region",
        .road_attributes = "RoadAttributes",
        .route_numbers = "RouteNumbers",
        .scooter_access = "ScooterAccess",
        .speed_limit = "SpeedLimit",
        .toll_systems = "TollSystems",
        .truck_access = "TruckAccess",
        .truck_road_types = "TruckRoadTypes",
        .typical_duration = "TypicalDuration",
        .zones = "Zones",
        .consumption = "Consumption",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .best_case_duration => "BestCaseDuration",
            .car_access => "CarAccess",
            .country => "Country",
            .distance => "Distance",
            .duration => "Duration",
            .dynamic_speed => "DynamicSpeed",
            .functional_classification => "FunctionalClassification",
            .gates => "Gates",
            .incidents => "Incidents",
            .names => "Names",
            .notices => "Notices",
            .pedestrian_access => "PedestrianAccess",
            .railway_crossings => "RailwayCrossings",
            .region => "Region",
            .road_attributes => "RoadAttributes",
            .route_numbers => "RouteNumbers",
            .scooter_access => "ScooterAccess",
            .speed_limit => "SpeedLimit",
            .toll_systems => "TollSystems",
            .truck_access => "TruckAccess",
            .truck_road_types => "TruckRoadTypes",
            .typical_duration => "TypicalDuration",
            .zones => "Zones",
            .consumption => "Consumption",
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

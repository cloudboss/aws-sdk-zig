const std = @import("std");

pub const RouteSpanRoadAttribute = enum {
    bridge,
    built_up_area,
    controlled_access_highway,
    dirt_road,
    divided_road,
    motorway,
    private_road,
    ramp,
    right_hand_traffic,
    roundabout,
    tunnel,
    under_construction,

    pub const json_field_names = .{
        .bridge = "Bridge",
        .built_up_area = "BuiltUpArea",
        .controlled_access_highway = "ControlledAccessHighway",
        .dirt_road = "DirtRoad",
        .divided_road = "DividedRoad",
        .motorway = "Motorway",
        .private_road = "PrivateRoad",
        .ramp = "Ramp",
        .right_hand_traffic = "RightHandTraffic",
        .roundabout = "Roundabout",
        .tunnel = "Tunnel",
        .under_construction = "UnderConstruction",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bridge => "Bridge",
            .built_up_area => "BuiltUpArea",
            .controlled_access_highway => "ControlledAccessHighway",
            .dirt_road => "DirtRoad",
            .divided_road => "DividedRoad",
            .motorway => "Motorway",
            .private_road => "PrivateRoad",
            .ramp => "Ramp",
            .right_hand_traffic => "RightHandTraffic",
            .roundabout => "Roundabout",
            .tunnel => "Tunnel",
            .under_construction => "UnderConstruction",
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

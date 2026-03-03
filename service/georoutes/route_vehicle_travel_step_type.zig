const std = @import("std");

pub const RouteVehicleTravelStepType = enum {
    arrive,
    @"continue",
    continue_highway,
    depart,
    enter_highway,
    exit,
    keep,
    ramp,
    roundabout_enter,
    roundabout_exit,
    roundabout_pass,
    turn,
    u_turn,

    pub const json_field_names = .{
        .arrive = "Arrive",
        .@"continue" = "Continue",
        .continue_highway = "ContinueHighway",
        .depart = "Depart",
        .enter_highway = "EnterHighway",
        .exit = "Exit",
        .keep = "Keep",
        .ramp = "Ramp",
        .roundabout_enter = "RoundaboutEnter",
        .roundabout_exit = "RoundaboutExit",
        .roundabout_pass = "RoundaboutPass",
        .turn = "Turn",
        .u_turn = "UTurn",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .arrive => "Arrive",
            .@"continue" => "Continue",
            .continue_highway => "ContinueHighway",
            .depart => "Depart",
            .enter_highway => "EnterHighway",
            .exit => "Exit",
            .keep => "Keep",
            .ramp => "Ramp",
            .roundabout_enter => "RoundaboutEnter",
            .roundabout_exit => "RoundaboutExit",
            .roundabout_pass => "RoundaboutPass",
            .turn => "Turn",
            .u_turn => "UTurn",
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

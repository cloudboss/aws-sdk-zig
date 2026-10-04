const std = @import("std");

pub const RouteIntermodalEnabledLegs = enum {
    first_leg,
    last_leg,
    entire_route,
    none,

    pub const json_field_names = .{
        .first_leg = "FirstLeg",
        .last_leg = "LastLeg",
        .entire_route = "EntireRoute",
        .none = "None",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .first_leg => "FirstLeg",
            .last_leg => "LastLeg",
            .entire_route => "EntireRoute",
            .none => "None",
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

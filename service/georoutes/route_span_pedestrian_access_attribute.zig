const std = @import("std");

pub const RouteSpanPedestrianAccessAttribute = enum {
    allowed,
    indoors,
    no_through_traffic,
    park,
    stairs,
    toll_road,

    pub const json_field_names = .{
        .allowed = "Allowed",
        .indoors = "Indoors",
        .no_through_traffic = "NoThroughTraffic",
        .park = "Park",
        .stairs = "Stairs",
        .toll_road = "TollRoad",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .allowed => "Allowed",
            .indoors => "Indoors",
            .no_through_traffic => "NoThroughTraffic",
            .park => "Park",
            .stairs => "Stairs",
            .toll_road => "TollRoad",
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

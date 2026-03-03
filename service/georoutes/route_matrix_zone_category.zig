const std = @import("std");

pub const RouteMatrixZoneCategory = enum {
    congestion_pricing,
    environmental,
    vignette,

    pub const json_field_names = .{
        .congestion_pricing = "CongestionPricing",
        .environmental = "Environmental",
        .vignette = "Vignette",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .congestion_pricing => "CongestionPricing",
            .environmental => "Environmental",
            .vignette => "Vignette",
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

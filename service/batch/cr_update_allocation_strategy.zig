const std = @import("std");

pub const CRUpdateAllocationStrategy = enum {
    best_fit_progressive,
    spot_capacity_optimized,
    spot_price_capacity_optimized,

    pub const json_field_names = .{
        .best_fit_progressive = "BEST_FIT_PROGRESSIVE",
        .spot_capacity_optimized = "SPOT_CAPACITY_OPTIMIZED",
        .spot_price_capacity_optimized = "SPOT_PRICE_CAPACITY_OPTIMIZED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .best_fit_progressive => "BEST_FIT_PROGRESSIVE",
            .spot_capacity_optimized => "SPOT_CAPACITY_OPTIMIZED",
            .spot_price_capacity_optimized => "SPOT_PRICE_CAPACITY_OPTIMIZED",
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

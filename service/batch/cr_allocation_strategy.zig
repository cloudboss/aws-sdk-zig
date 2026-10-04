const std = @import("std");

pub const CRAllocationStrategy = enum {
    best_fit,
    best_fit_progressive,
    best_fit_progressive_ordered,
    spot_capacity_optimized,
    spot_price_capacity_optimized,
    spot_capacity_optimized_prioritized,

    pub const json_field_names = .{
        .best_fit = "BEST_FIT",
        .best_fit_progressive = "BEST_FIT_PROGRESSIVE",
        .best_fit_progressive_ordered = "BEST_FIT_PROGRESSIVE_ORDERED",
        .spot_capacity_optimized = "SPOT_CAPACITY_OPTIMIZED",
        .spot_price_capacity_optimized = "SPOT_PRICE_CAPACITY_OPTIMIZED",
        .spot_capacity_optimized_prioritized = "SPOT_CAPACITY_OPTIMIZED_PRIORITIZED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .best_fit => "BEST_FIT",
            .best_fit_progressive => "BEST_FIT_PROGRESSIVE",
            .best_fit_progressive_ordered => "BEST_FIT_PROGRESSIVE_ORDERED",
            .spot_capacity_optimized => "SPOT_CAPACITY_OPTIMIZED",
            .spot_price_capacity_optimized => "SPOT_PRICE_CAPACITY_OPTIMIZED",
            .spot_capacity_optimized_prioritized => "SPOT_CAPACITY_OPTIMIZED_PRIORITIZED",
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

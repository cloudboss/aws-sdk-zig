const std = @import("std");

pub const CRUpdateAllocationStrategy = enum {
    best_fit_progressive,
    best_fit_progressive_ordered,
    spot_capacity_optimized,
    spot_price_capacity_optimized,
    spot_capacity_optimized_prioritized,

    pub const json_field_names = .{
        .best_fit_progressive = "BEST_FIT_PROGRESSIVE",
        .best_fit_progressive_ordered = "BEST_FIT_PROGRESSIVE_ORDERED",
        .spot_capacity_optimized = "SPOT_CAPACITY_OPTIMIZED",
        .spot_price_capacity_optimized = "SPOT_PRICE_CAPACITY_OPTIMIZED",
        .spot_capacity_optimized_prioritized = "SPOT_CAPACITY_OPTIMIZED_PRIORITIZED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .best_fit_progressive => "BEST_FIT_PROGRESSIVE",
            .best_fit_progressive_ordered => "BEST_FIT_PROGRESSIVE_ORDERED",
            .spot_capacity_optimized => "SPOT_CAPACITY_OPTIMIZED",
            .spot_price_capacity_optimized => "SPOT_PRICE_CAPACITY_OPTIMIZED",
            .spot_capacity_optimized_prioritized => "SPOT_CAPACITY_OPTIMIZED_PRIORITIZED",
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

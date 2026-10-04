const std = @import("std");

pub const AllocationStrategy = enum {
    lowest_price,
    diversified,
    capacity_optimized,
    capacity_optimized_prioritized,
    price_capacity_optimized,

    pub const json_field_names = .{
        .lowest_price = "lowestPrice",
        .diversified = "diversified",
        .capacity_optimized = "capacityOptimized",
        .capacity_optimized_prioritized = "capacityOptimizedPrioritized",
        .price_capacity_optimized = "priceCapacityOptimized",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .lowest_price => "lowestPrice",
            .diversified => "diversified",
            .capacity_optimized => "capacityOptimized",
            .capacity_optimized_prioritized => "capacityOptimizedPrioritized",
            .price_capacity_optimized => "priceCapacityOptimized",
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

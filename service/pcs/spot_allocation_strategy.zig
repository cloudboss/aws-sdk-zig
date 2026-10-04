const std = @import("std");

pub const SpotAllocationStrategy = enum {
    lowest_price,
    capacity_optimized,
    price_capacity_optimized,

    pub const json_field_names = .{
        .lowest_price = "lowest-price",
        .capacity_optimized = "capacity-optimized",
        .price_capacity_optimized = "price-capacity-optimized",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .lowest_price => "lowest-price",
            .capacity_optimized => "capacity-optimized",
            .price_capacity_optimized => "price-capacity-optimized",
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

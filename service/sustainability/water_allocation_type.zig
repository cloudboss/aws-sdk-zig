const std = @import("std");

/// Specifies the types of water allocation calculations available.
pub const WaterAllocationType = enum {
    /// Total water drawn from surface water, groundwater, seawater, or a third
    /// party associated with Amazon Web Services account usage.
    total_water_withdrawals,

    pub const json_field_names = .{
        .total_water_withdrawals = "TOTAL_WATER_WITHDRAWALS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .total_water_withdrawals => "TOTAL_WATER_WITHDRAWALS",
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

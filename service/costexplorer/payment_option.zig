const std = @import("std");

pub const PaymentOption = enum {
    no_upfront,
    partial_upfront,
    all_upfront,
    light_utilization,
    medium_utilization,
    heavy_utilization,

    pub const json_field_names = .{
        .no_upfront = "NO_UPFRONT",
        .partial_upfront = "PARTIAL_UPFRONT",
        .all_upfront = "ALL_UPFRONT",
        .light_utilization = "LIGHT_UTILIZATION",
        .medium_utilization = "MEDIUM_UTILIZATION",
        .heavy_utilization = "HEAVY_UTILIZATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_upfront => "NO_UPFRONT",
            .partial_upfront => "PARTIAL_UPFRONT",
            .all_upfront => "ALL_UPFRONT",
            .light_utilization => "LIGHT_UTILIZATION",
            .medium_utilization => "MEDIUM_UTILIZATION",
            .heavy_utilization => "HEAVY_UTILIZATION",
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

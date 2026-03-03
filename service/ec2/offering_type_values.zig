const std = @import("std");

pub const OfferingTypeValues = enum {
    heavy_utilization,
    medium_utilization,
    light_utilization,
    no_upfront,
    partial_upfront,
    all_upfront,

    pub const json_field_names = .{
        .heavy_utilization = "Heavy Utilization",
        .medium_utilization = "Medium Utilization",
        .light_utilization = "Light Utilization",
        .no_upfront = "No Upfront",
        .partial_upfront = "Partial Upfront",
        .all_upfront = "All Upfront",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .heavy_utilization => "Heavy Utilization",
            .medium_utilization => "Medium Utilization",
            .light_utilization => "Light Utilization",
            .no_upfront => "No Upfront",
            .partial_upfront => "Partial Upfront",
            .all_upfront => "All Upfront",
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

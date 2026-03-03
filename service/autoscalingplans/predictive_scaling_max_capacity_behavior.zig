const std = @import("std");

pub const PredictiveScalingMaxCapacityBehavior = enum {
    set_forecast_capacity_to_max_capacity,
    set_max_capacity_to_forecast_capacity,
    set_max_capacity_above_forecast_capacity,

    pub const json_field_names = .{
        .set_forecast_capacity_to_max_capacity = "SetForecastCapacityToMaxCapacity",
        .set_max_capacity_to_forecast_capacity = "SetMaxCapacityToForecastCapacity",
        .set_max_capacity_above_forecast_capacity = "SetMaxCapacityAboveForecastCapacity",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .set_forecast_capacity_to_max_capacity => "SetForecastCapacityToMaxCapacity",
            .set_max_capacity_to_forecast_capacity => "SetMaxCapacityToForecastCapacity",
            .set_max_capacity_above_forecast_capacity => "SetMaxCapacityAboveForecastCapacity",
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

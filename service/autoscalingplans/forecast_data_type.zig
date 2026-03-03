const std = @import("std");

pub const ForecastDataType = enum {
    capacity_forecast,
    load_forecast,
    scheduled_action_min_capacity,
    scheduled_action_max_capacity,

    pub const json_field_names = .{
        .capacity_forecast = "CapacityForecast",
        .load_forecast = "LoadForecast",
        .scheduled_action_min_capacity = "ScheduledActionMinCapacity",
        .scheduled_action_max_capacity = "ScheduledActionMaxCapacity",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .capacity_forecast => "CapacityForecast",
            .load_forecast => "LoadForecast",
            .scheduled_action_min_capacity => "ScheduledActionMinCapacity",
            .scheduled_action_max_capacity => "ScheduledActionMaxCapacity",
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

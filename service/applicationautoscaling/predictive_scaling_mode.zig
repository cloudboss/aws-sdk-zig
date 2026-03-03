const std = @import("std");

pub const PredictiveScalingMode = enum {
    forecast_only,
    forecast_and_scale,

    pub const json_field_names = .{
        .forecast_only = "ForecastOnly",
        .forecast_and_scale = "ForecastAndScale",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .forecast_only => "ForecastOnly",
            .forecast_and_scale => "ForecastAndScale",
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

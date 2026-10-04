const std = @import("std");

pub const RxNormAttributeType = enum {
    dosage,
    duration,
    form,
    frequency,
    rate,
    route_or_mode,
    strength,

    pub const json_field_names = .{
        .dosage = "DOSAGE",
        .duration = "DURATION",
        .form = "FORM",
        .frequency = "FREQUENCY",
        .rate = "RATE",
        .route_or_mode = "ROUTE_OR_MODE",
        .strength = "STRENGTH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .dosage => "DOSAGE",
            .duration => "DURATION",
            .form => "FORM",
            .frequency => "FREQUENCY",
            .rate => "RATE",
            .route_or_mode => "ROUTE_OR_MODE",
            .strength => "STRENGTH",
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

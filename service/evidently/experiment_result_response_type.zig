const std = @import("std");

pub const ExperimentResultResponseType = enum {
    mean,
    treatment_effect,
    confidence_interval_upperbound,
    confidence_interval_lowerbound,
    p_value,

    pub const json_field_names = .{
        .mean = "Mean",
        .treatment_effect = "TreatmentEffect",
        .confidence_interval_upperbound = "ConfidenceIntervalUpperBound",
        .confidence_interval_lowerbound = "ConfidenceIntervalLowerBound",
        .p_value = "PValue",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .mean => "Mean",
            .treatment_effect => "TreatmentEffect",
            .confidence_interval_upperbound => "ConfidenceIntervalUpperBound",
            .confidence_interval_lowerbound => "ConfidenceIntervalLowerBound",
            .p_value => "PValue",
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

const std = @import("std");

pub const AttributeName = enum {
    sign,
    symptom,
    diagnosis,
    negation,
    pertains_to_family,
    hypothetical,
    low_confidence,
    past_history,
    future,

    pub const json_field_names = .{
        .sign = "SIGN",
        .symptom = "SYMPTOM",
        .diagnosis = "DIAGNOSIS",
        .negation = "NEGATION",
        .pertains_to_family = "PERTAINS_TO_FAMILY",
        .hypothetical = "HYPOTHETICAL",
        .low_confidence = "LOW_CONFIDENCE",
        .past_history = "PAST_HISTORY",
        .future = "FUTURE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sign => "SIGN",
            .symptom => "SYMPTOM",
            .diagnosis => "DIAGNOSIS",
            .negation => "NEGATION",
            .pertains_to_family => "PERTAINS_TO_FAMILY",
            .hypothetical => "HYPOTHETICAL",
            .low_confidence => "LOW_CONFIDENCE",
            .past_history => "PAST_HISTORY",
            .future => "FUTURE",
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

const std = @import("std");

pub const FraudDetectionDecision = enum {
    high_risk,
    low_risk,
    not_enough_speech,

    pub const json_field_names = .{
        .high_risk = "HIGH_RISK",
        .low_risk = "LOW_RISK",
        .not_enough_speech = "NOT_ENOUGH_SPEECH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .high_risk => "HIGH_RISK",
            .low_risk => "LOW_RISK",
            .not_enough_speech => "NOT_ENOUGH_SPEECH",
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

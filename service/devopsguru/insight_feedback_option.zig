const std = @import("std");

pub const InsightFeedbackOption = enum {
    valid_collection,
    recommendation_useful,
    alert_too_sensitive,
    data_noisy_anomaly,
    data_incorrect,

    pub const json_field_names = .{
        .valid_collection = "VALID_COLLECTION",
        .recommendation_useful = "RECOMMENDATION_USEFUL",
        .alert_too_sensitive = "ALERT_TOO_SENSITIVE",
        .data_noisy_anomaly = "DATA_NOISY_ANOMALY",
        .data_incorrect = "DATA_INCORRECT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .valid_collection => "VALID_COLLECTION",
            .recommendation_useful => "RECOMMENDATION_USEFUL",
            .alert_too_sensitive => "ALERT_TOO_SENSITIVE",
            .data_noisy_anomaly => "DATA_NOISY_ANOMALY",
            .data_incorrect => "DATA_INCORRECT",
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

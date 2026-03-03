const std = @import("std");

pub const TransitionToArchiveRules = enum {
    after_1_day,
    after_7_days,
    after_14_days,
    after_30_days,
    after_60_days,
    after_90_days,
    after_180_days,
    after_270_days,
    after_365_days,

    pub const json_field_names = .{
        .after_1_day = "AFTER_1_DAY",
        .after_7_days = "AFTER_7_DAYS",
        .after_14_days = "AFTER_14_DAYS",
        .after_30_days = "AFTER_30_DAYS",
        .after_60_days = "AFTER_60_DAYS",
        .after_90_days = "AFTER_90_DAYS",
        .after_180_days = "AFTER_180_DAYS",
        .after_270_days = "AFTER_270_DAYS",
        .after_365_days = "AFTER_365_DAYS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .after_1_day => "AFTER_1_DAY",
            .after_7_days => "AFTER_7_DAYS",
            .after_14_days => "AFTER_14_DAYS",
            .after_30_days => "AFTER_30_DAYS",
            .after_60_days => "AFTER_60_DAYS",
            .after_90_days => "AFTER_90_DAYS",
            .after_180_days => "AFTER_180_DAYS",
            .after_270_days => "AFTER_270_DAYS",
            .after_365_days => "AFTER_365_DAYS",
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

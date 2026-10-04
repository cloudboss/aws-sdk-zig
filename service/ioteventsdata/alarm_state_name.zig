const std = @import("std");

pub const AlarmStateName = enum {
    disabled,
    normal,
    active,
    acknowledged,
    snooze_disabled,
    latched,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .normal = "NORMAL",
        .active = "ACTIVE",
        .acknowledged = "ACKNOWLEDGED",
        .snooze_disabled = "SNOOZE_DISABLED",
        .latched = "LATCHED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disabled => "DISABLED",
            .normal => "NORMAL",
            .active => "ACTIVE",
            .acknowledged => "ACKNOWLEDGED",
            .snooze_disabled => "SNOOZE_DISABLED",
            .latched => "LATCHED",
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

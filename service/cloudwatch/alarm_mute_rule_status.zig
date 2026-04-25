const std = @import("std");

pub const AlarmMuteRuleStatus = enum {
    scheduled,
    active,
    expired,

    pub const json_field_names = .{
        .scheduled = "SCHEDULED",
        .active = "ACTIVE",
        .expired = "EXPIRED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .scheduled => "SCHEDULED",
            .active => "ACTIVE",
            .expired => "EXPIRED",
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

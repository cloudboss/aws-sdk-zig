const std = @import("std");

pub const ContactType = enum {
    personal,
    escalation,
    oncall_schedule,

    pub const json_field_names = .{
        .personal = "PERSONAL",
        .escalation = "ESCALATION",
        .oncall_schedule = "ONCALL_SCHEDULE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .personal => "PERSONAL",
            .escalation => "ESCALATION",
            .oncall_schedule => "ONCALL_SCHEDULE",
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

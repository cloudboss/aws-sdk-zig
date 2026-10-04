const std = @import("std");

pub const ParticipantRole = enum {
    agent,
    customer,
    system,
    custom_bot,
    supervisor,

    pub const json_field_names = .{
        .agent = "AGENT",
        .customer = "CUSTOMER",
        .system = "SYSTEM",
        .custom_bot = "CUSTOM_BOT",
        .supervisor = "SUPERVISOR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .agent => "AGENT",
            .customer => "CUSTOMER",
            .system => "SYSTEM",
            .custom_bot => "CUSTOM_BOT",
            .supervisor => "SUPERVISOR",
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

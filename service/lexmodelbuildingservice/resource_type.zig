const std = @import("std");

pub const ResourceType = enum {
    bot,
    intent,
    slot_type,

    pub const json_field_names = .{
        .bot = "BOT",
        .intent = "INTENT",
        .slot_type = "SLOT_TYPE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bot => "BOT",
            .intent => "INTENT",
            .slot_type => "SLOT_TYPE",
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

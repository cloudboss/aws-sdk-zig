const std = @import("std");

pub const FulfillmentActivityType = enum {
    return_intent,
    code_hook,

    pub const json_field_names = .{
        .return_intent = "ReturnIntent",
        .code_hook = "CodeHook",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .return_intent => "ReturnIntent",
            .code_hook => "CodeHook",
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

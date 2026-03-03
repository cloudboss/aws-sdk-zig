const std = @import("std");

pub const DialogActionType = enum {
    elicit_intent,
    confirm_intent,
    elicit_slot,
    close,
    delegate,

    pub const json_field_names = .{
        .elicit_intent = "ElicitIntent",
        .confirm_intent = "ConfirmIntent",
        .elicit_slot = "ElicitSlot",
        .close = "Close",
        .delegate = "Delegate",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .elicit_intent => "ElicitIntent",
            .confirm_intent => "ConfirmIntent",
            .elicit_slot => "ElicitSlot",
            .close => "Close",
            .delegate => "Delegate",
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

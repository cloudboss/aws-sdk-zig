const std = @import("std");

pub const DialogActionType = enum {
    close,
    confirm_intent,
    delegate,
    elicit_intent,
    elicit_slot,
    none,

    pub const json_field_names = .{
        .close = "Close",
        .confirm_intent = "ConfirmIntent",
        .delegate = "Delegate",
        .elicit_intent = "ElicitIntent",
        .elicit_slot = "ElicitSlot",
        .none = "None",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .close => "Close",
            .confirm_intent => "ConfirmIntent",
            .delegate => "Delegate",
            .elicit_intent => "ElicitIntent",
            .elicit_slot => "ElicitSlot",
            .none => "None",
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

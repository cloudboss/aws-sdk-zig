const std = @import("std");

pub const SignalDecoderType = enum {
    can_signal,
    obd_signal,
    message_signal,
    custom_decoding_signal,

    pub const json_field_names = .{
        .can_signal = "CAN_SIGNAL",
        .obd_signal = "OBD_SIGNAL",
        .message_signal = "MESSAGE_SIGNAL",
        .custom_decoding_signal = "CUSTOM_DECODING_SIGNAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .can_signal => "CAN_SIGNAL",
            .obd_signal => "OBD_SIGNAL",
            .message_signal => "MESSAGE_SIGNAL",
            .custom_decoding_signal => "CUSTOM_DECODING_SIGNAL",
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

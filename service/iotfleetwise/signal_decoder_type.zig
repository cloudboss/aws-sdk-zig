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
};

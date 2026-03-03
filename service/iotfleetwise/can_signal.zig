const SignalValueType = @import("signal_value_type.zig").SignalValueType;

/// Information about a single controller area network (CAN) signal and the
/// messages it
/// receives and transmits.
pub const CanSignal = struct {
    /// A multiplier used to decode the CAN message.
    factor: f64,

    /// Whether the byte ordering of a CAN message is big-endian.
    is_big_endian: bool = false,

    /// Determines whether the message is signed (`true`) or not (`false`). If it's
    /// signed, the message can represent both positive and negative numbers. The
    /// `isSigned` parameter only applies to the `INTEGER` raw signal type, and it
    /// doesn't affect the `FLOATING_POINT` raw signal type.
    is_signed: bool = false,

    /// How many bytes of data are in the message.
    length: i32 = 0,

    /// The ID of the message.
    message_id: i32 = 0,

    /// The name of the signal.
    name: ?[]const u8 = null,

    /// The offset used to calculate the signal value. Combined with factor, the
    /// calculation
    /// is `value = raw_value * factor + offset`.
    offset: f64,

    /// The value type of the signal. The default value is `INTEGER`.
    signal_value_type: ?SignalValueType = null,

    /// Indicates the beginning of the CAN signal. This should always be the least
    /// significant
    /// bit (LSB).
    ///
    /// This value might be different from the value in a DBC file. For little
    /// endian signals,
    /// `startBit` is the same value as in the DBC file. For big endian signals
    /// in a DBC file, the start bit is the most significant bit (MSB). You will
    /// have to
    /// calculate the LSB instead and pass it as the `startBit`.
    start_bit: i32 = 0,

    pub const json_field_names = .{
        .factor = "factor",
        .is_big_endian = "isBigEndian",
        .is_signed = "isSigned",
        .length = "length",
        .message_id = "messageId",
        .name = "name",
        .offset = "offset",
        .signal_value_type = "signalValueType",
        .start_bit = "startBit",
    };
};

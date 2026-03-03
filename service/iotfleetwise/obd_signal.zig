const SignalValueType = @import("signal_value_type.zig").SignalValueType;

/// Information about signal messages using the on-board diagnostics (OBD) II
/// protocol in
/// a vehicle.
pub const ObdSignal = struct {
    /// The number of bits to mask in a message.
    bit_mask_length: ?i32 = null,

    /// The number of positions to shift bits in the message.
    bit_right_shift: i32 = 0,

    /// The length of a message.
    byte_length: i32,

    /// Determines whether the message is signed (`true`) or not (`false`). If it's
    /// signed, the message can represent both positive and negative numbers. The
    /// `isSigned` parameter only applies to the `INTEGER` raw signal type, and it
    /// doesn't affect the `FLOATING_POINT` raw signal type. The default value is
    /// `false`.
    is_signed: ?bool = null,

    /// The offset used to calculate the signal value. Combined with scaling, the
    /// calculation
    /// is `value = raw_value * scaling + offset`.
    offset: f64,

    /// The diagnostic code used to request data from a vehicle for this signal.
    pid: i32 = 0,

    /// The length of the requested data.
    pid_response_length: i32,

    /// A multiplier used to decode the message.
    scaling: f64,

    /// The mode of operation (diagnostic service) in a message.
    service_mode: i32 = 0,

    /// The value type of the signal. The default value is `INTEGER`.
    signal_value_type: ?SignalValueType = null,

    /// Indicates the beginning of the message.
    start_byte: i32 = 0,

    pub const json_field_names = .{
        .bit_mask_length = "bitMaskLength",
        .bit_right_shift = "bitRightShift",
        .byte_length = "byteLength",
        .is_signed = "isSigned",
        .offset = "offset",
        .pid = "pid",
        .pid_response_length = "pidResponseLength",
        .scaling = "scaling",
        .service_mode = "serviceMode",
        .signal_value_type = "signalValueType",
        .start_byte = "startByte",
    };
};

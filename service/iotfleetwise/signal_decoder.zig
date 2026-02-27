const CanSignal = @import("can_signal.zig").CanSignal;
const CustomDecodingSignal = @import("custom_decoding_signal.zig").CustomDecodingSignal;
const MessageSignal = @import("message_signal.zig").MessageSignal;
const ObdSignal = @import("obd_signal.zig").ObdSignal;
const SignalDecoderType = @import("signal_decoder_type.zig").SignalDecoderType;

/// Information about a signal decoder.
pub const SignalDecoder = struct {
    /// Information about signal decoder using the Controller Area Network (CAN)
    /// protocol.
    can_signal: ?CanSignal,

    /// Information about a [custom signal
    /// decoder](https://docs.aws.amazon.com/iot-fleetwise/latest/APIReference/API_CustomDecodingSignal.html).
    ///
    /// Access to certain Amazon Web Services IoT FleetWise features is currently
    /// gated. For more information, see [Amazon Web Services Region and feature
    /// availability](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/fleetwise-regions.html) in the *Amazon Web Services IoT FleetWise Developer Guide*.
    custom_decoding_signal: ?CustomDecodingSignal,

    /// The fully qualified name of a signal decoder as defined in a vehicle model.
    fully_qualified_name: []const u8,

    /// The ID of a network interface that specifies what network protocol a vehicle
    /// follows.
    interface_id: []const u8,

    /// The decoding information for a specific message which supports higher order
    /// data
    /// types.
    message_signal: ?MessageSignal,

    /// Information about signal decoder using the on-board diagnostic (OBD) II
    /// protocol.
    obd_signal: ?ObdSignal,

    /// The network protocol for the vehicle. For example, `CAN_SIGNAL` specifies a
    /// protocol that defines how data is communicated between electronic control
    /// units (ECUs).
    /// `OBD_SIGNAL` specifies a protocol that defines how self-diagnostic data
    /// is communicated between ECUs.
    type: SignalDecoderType,

    pub const json_field_names = .{
        .can_signal = "canSignal",
        .custom_decoding_signal = "customDecodingSignal",
        .fully_qualified_name = "fullyQualifiedName",
        .interface_id = "interfaceId",
        .message_signal = "messageSignal",
        .obd_signal = "obdSignal",
        .type = "type",
    };
};

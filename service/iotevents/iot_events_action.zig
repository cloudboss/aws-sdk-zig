const Payload = @import("payload.zig").Payload;

/// Sends an AWS IoT Events input, passing in information about the detector
/// model instance and the
/// event that triggered the action.
pub const IotEventsAction = struct {
    /// The name of the AWS IoT Events input where the data is sent.
    input_name: []const u8,

    /// You can configure the action payload when you send a message to an AWS IoT
    /// Events input.
    payload: ?Payload,

    pub const json_field_names = .{
        .input_name = "inputName",
        .payload = "payload",
    };
};

/// The identifier of the input routed to AWS IoT Events.
pub const IotEventsInputIdentifier = struct {
    /// The name of the input routed to AWS IoT Events.
    input_name: []const u8,

    pub const json_field_names = .{
        .input_name = "inputName",
    };
};

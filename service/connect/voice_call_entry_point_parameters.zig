/// Parameters for initiating a voice call test.
pub const VoiceCallEntryPointParameters = struct {
    /// The destination phone number for the test.
    destination_phone_number: ?[]const u8 = null,

    /// The flow identifier for the test.
    flow_id: ?[]const u8 = null,

    /// The source phone number for the test.
    source_phone_number: ?[]const u8 = null,

    pub const json_field_names = .{
        .destination_phone_number = "DestinationPhoneNumber",
        .flow_id = "FlowId",
        .source_phone_number = "SourcePhoneNumber",
    };
};

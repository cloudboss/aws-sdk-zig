/// The outbound caller ID name, number, and outbound whisper flow.
pub const OutboundCallerConfig = struct {
    /// The caller ID name.
    outbound_caller_id_name: ?[]const u8,

    /// The caller ID number.
    outbound_caller_id_number_id: ?[]const u8,

    /// The outbound whisper flow to be used during an outbound call.
    outbound_flow_id: ?[]const u8,

    pub const json_field_names = .{
        .outbound_caller_id_name = "OutboundCallerIdName",
        .outbound_caller_id_number_id = "OutboundCallerIdNumberId",
        .outbound_flow_id = "OutboundFlowId",
    };
};

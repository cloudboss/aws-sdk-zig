/// Parameters for initiating a chat test.
pub const ChatEntryPointParameters = struct {
    /// The flow identifier for the test.
    flow_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .flow_id = "FlowId",
    };
};

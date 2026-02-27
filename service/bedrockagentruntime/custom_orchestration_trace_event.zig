/// The event in the custom orchestration sequence. Events are the responses
/// which the custom orchestration Lambda function sends as response to the
/// agent.
pub const CustomOrchestrationTraceEvent = struct {
    /// The text that prompted the event at this step.
    text: ?[]const u8,

    pub const json_field_names = .{
        .text = "text",
    };
};

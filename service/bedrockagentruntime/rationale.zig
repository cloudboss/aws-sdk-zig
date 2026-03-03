/// Contains the reasoning, based on the input, that the agent uses to justify
/// carrying out an action group or getting information from a knowledge base.
pub const Rationale = struct {
    /// The reasoning or thought process of the agent, based on the input.
    text: ?[]const u8 = null,

    /// The unique identifier of the trace step.
    trace_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .text = "text",
        .trace_id = "traceId",
    };
};

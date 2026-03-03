const ReturnControlResults = @import("return_control_results.zig").ReturnControlResults;
const PayloadType = @import("payload_type.zig").PayloadType;

/// Input for an agent collaborator. The input can be text or an action
/// invocation result.
pub const AgentCollaboratorInputPayload = struct {
    /// An action invocation result.
    return_control_results: ?ReturnControlResults = null,

    /// Input text.
    text: ?[]const u8 = null,

    /// The input type.
    @"type": ?PayloadType = null,

    pub const json_field_names = .{
        .return_control_results = "returnControlResults",
        .text = "text",
        .@"type" = "type",
    };
};

const ReturnControlPayload = @import("return_control_payload.zig").ReturnControlPayload;
const PayloadType = @import("payload_type.zig").PayloadType;

/// Output from an agent collaborator. The output can be text or an action
/// invocation result.
pub const AgentCollaboratorOutputPayload = struct {
    /// An action invocation result.
    return_control_payload: ?ReturnControlPayload = null,

    /// Text output.
    text: ?[]const u8 = null,

    /// The type of output.
    @"type": ?PayloadType = null,

    pub const json_field_names = .{
        .return_control_payload = "returnControlPayload",
        .text = "text",
        .@"type" = "type",
    };
};

const PipeState = @import("pipe_state.zig").PipeState;
const RequestedPipeState = @import("requested_pipe_state.zig").RequestedPipeState;

/// An object that represents a pipe. Amazon EventBridgePipes connect event
/// sources to
/// targets and reduces the need for specialized knowledge and integration code.
pub const Pipe = struct {
    /// The ARN of the pipe.
    arn: ?[]const u8,

    /// The time the pipe was created.
    creation_time: ?i64,

    /// The state the pipe is in.
    current_state: ?PipeState,

    /// The state the pipe should be in.
    desired_state: ?RequestedPipeState,

    /// The ARN of the enrichment resource.
    enrichment: ?[]const u8,

    /// When the pipe was last updated, in [ISO-8601
    /// format](https://www.w3.org/TR/NOTE-datetime) (YYYY-MM-DDThh:mm:ss.sTZD).
    last_modified_time: ?i64,

    /// The name of the pipe.
    name: ?[]const u8,

    /// The ARN of the source resource.
    source: ?[]const u8,

    /// The reason the pipe is in its current state.
    state_reason: ?[]const u8,

    /// The ARN of the target resource.
    target: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .current_state = "CurrentState",
        .desired_state = "DesiredState",
        .enrichment = "Enrichment",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .source = "Source",
        .state_reason = "StateReason",
        .target = "Target",
    };
};

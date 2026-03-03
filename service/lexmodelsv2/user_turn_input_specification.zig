const aws = @import("aws");

const InputSessionStateSpecification = @import("input_session_state_specification.zig").InputSessionStateSpecification;
const UtteranceInputSpecification = @import("utterance_input_specification.zig").UtteranceInputSpecification;

/// Contains information about the user messages in the turn in the input.
pub const UserTurnInputSpecification = struct {
    /// Request attributes of the user turn.
    request_attributes: ?[]const aws.map.StringMapEntry = null,

    /// Contains information about the session state in the input.
    session_state: ?InputSessionStateSpecification = null,

    /// The utterance input in the user turn.
    utterance_input: UtteranceInputSpecification,

    pub const json_field_names = .{
        .request_attributes = "requestAttributes",
        .session_state = "sessionState",
        .utterance_input = "utteranceInput",
    };
};

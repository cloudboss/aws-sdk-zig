const UserTurnOutputSpecification = @import("user_turn_output_specification.zig").UserTurnOutputSpecification;
const UserTurnInputSpecification = @import("user_turn_input_specification.zig").UserTurnInputSpecification;

/// Contains information about the expected and input values for the user turn.
pub const UserTurnSpecification = struct {
    /// Contains results about the expected output for the user turn.
    expected: UserTurnOutputSpecification,

    /// Contains information about the user messages in the turn in the input.
    input: UserTurnInputSpecification,

    pub const json_field_names = .{
        .expected = "expected",
        .input = "input",
    };
};

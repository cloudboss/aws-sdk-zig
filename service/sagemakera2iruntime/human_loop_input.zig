/// An object containing the human loop input in JSON format.
pub const HumanLoopInput = struct {
    /// Serialized input from the human loop. The input must be a string
    /// representation of a file in JSON format.
    input_content: []const u8,

    pub const json_field_names = .{
        .input_content = "InputContent",
    };
};

/// The input for a ground truth conversation turn.
pub const GroundTruthTurnInput = union(enum) {
    /// The text prompt for this conversation turn.
    prompt: ?[]const u8,

    pub const json_field_names = .{
        .prompt = "prompt",
    };
};

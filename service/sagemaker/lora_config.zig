/// The Low-Rank Adaptation (LoRA) configuration for a training session,
/// including the rank and alpha parameters.
pub const LoraConfig = struct {
    /// The Low-Rank Adaptation (LoRA) scaling factor.
    alpha: i32,

    /// The rank of the Low-Rank Adaptation (LoRA) adapter matrices.
    rank: i32,

    pub const json_field_names = .{
        .alpha = "Alpha",
        .rank = "Rank",
    };
};

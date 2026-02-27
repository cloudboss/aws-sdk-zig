/// The possible Amazon Web Services Free Tier configurations.
pub const UpdateFreeTierConfig = struct {
    /// Activate or deactivate application of Amazon Web Services Free Tier.
    activated: bool,

    pub const json_field_names = .{
        .activated = "Activated",
    };
};

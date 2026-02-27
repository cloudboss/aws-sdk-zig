/// The possible Amazon Web Services Free Tier configurations.
pub const CreateFreeTierConfig = struct {
    /// Activate or deactivate Amazon Web Services Free Tier.
    activated: bool,

    pub const json_field_names = .{
        .activated = "Activated",
    };
};

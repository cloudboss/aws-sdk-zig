/// The possible Amazon Web Services Free Tier configurations.
pub const FreeTierConfig = struct {
    /// Activate or deactivate Amazon Web Services Free Tier application.
    activated: bool,

    pub const json_field_names = .{
        .activated = "Activated",
    };
};

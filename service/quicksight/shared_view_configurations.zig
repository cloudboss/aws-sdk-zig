/// The shared view settings of an embedded dashboard.
pub const SharedViewConfigurations = struct {
    /// The shared view settings of an embedded dashboard.
    enabled: bool = false,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};

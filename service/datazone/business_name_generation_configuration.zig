/// The configuration of the business name generation.
pub const BusinessNameGenerationConfiguration = struct {
    /// Specifies whether the business name generation is enabled.
    enabled: ?bool,

    pub const json_field_names = .{
        .enabled = "enabled",
    };
};

/// A specification for an environment configuration.
pub const SourceConfiguration = struct {
    /// The name of the application associated with the configuration.
    application_name: ?[]const u8 = null,

    /// The name of the configuration template.
    template_name: ?[]const u8 = null,
};

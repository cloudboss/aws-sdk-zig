/// Specifies whether serverless vector acceleration is enabled for the
/// collection.
pub const ServerlessVectorAccelerationStatus = enum {
    /// Serverless vector acceleration is enabled by default
    enabled,
    /// Serverless vector acceleration is disabled
    disabled,
    /// Serverless vector acceleration is allowed but not enabled by default
    allowed,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
        .allowed = "ALLOWED",
    };
};

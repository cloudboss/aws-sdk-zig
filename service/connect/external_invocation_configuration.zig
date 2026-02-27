/// The external invocation configuration for the flow module
pub const ExternalInvocationConfiguration = struct {
    /// Enable external invocation.
    enabled: bool = false,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};

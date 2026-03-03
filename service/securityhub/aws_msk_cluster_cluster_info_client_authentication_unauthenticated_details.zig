/// Provides details for allowing no client authentication.
pub const AwsMskClusterClusterInfoClientAuthenticationUnauthenticatedDetails = struct {
    /// Indicates whether unauthenticated is allowed or not.
    enabled: ?bool = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};

/// Provides details for allowing no client authentication.
pub const AwsMskClusterClusterInfoClientAuthenticationUnauthenticatedDetails = struct {
    /// Indicates whether unauthenticated is allowed or not.
    enabled: ?bool,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};

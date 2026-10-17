/// The response object containing configuration details for an ACK (Amazon Web
/// Services Controllers for Kubernetes) capability.
pub const AckConfigResponse = struct {
    /// The list of ACK service names whose controllers are turned off for this
    /// capability. Existing custom resource definitions remain installed, and
    /// resources of a disabled service aren't reconciled until the service is
    /// re-enabled.
    disabled_services: ?[]const []const u8 = null,

    /// Indicates whether ACK controllers resolve resource references to resources
    /// in a different Kubernetes namespace. This value reflects the setting that's
    /// in effect, and is `false` if you never specified a value. Capabilities that
    /// were using cross-namespace references before this setting became available
    /// have this value set to `true`, so their behavior is unchanged.
    enable_cross_namespace: ?bool = null,

    pub const json_field_names = .{
        .disabled_services = "disabledServices",
        .enable_cross_namespace = "enableCrossNamespace",
    };
};

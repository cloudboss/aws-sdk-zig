/// The namespace configuration request object for specifying a custom namespace
/// when creating an addon.
pub const AddonNamespaceConfigRequest = struct {
    /// The name of the Kubernetes namespace to install the addon in. Must be a
    /// valid RFC 1123 DNS label.
    namespace: ?[]const u8,

    pub const json_field_names = .{
        .namespace = "namespace",
    };
};

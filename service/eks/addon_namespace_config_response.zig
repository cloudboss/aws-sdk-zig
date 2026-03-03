/// The namespace configuration response object containing information about the
/// namespace where an addon is installed.
pub const AddonNamespaceConfigResponse = struct {
    /// The name of the Kubernetes namespace where the addon is installed.
    namespace: ?[]const u8 = null,

    pub const json_field_names = .{
        .namespace = "namespace",
    };
};

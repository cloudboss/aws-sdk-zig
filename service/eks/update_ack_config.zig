/// Configuration updates for an ACK (Amazon Web Services Controllers for
/// Kubernetes) capability. You only need to specify the fields that you want to
/// update.
pub const UpdateAckConfig = struct {
    /// An updated list of ACK service names whose controllers are turned off for
    /// this capability. This list replaces the previous list instead of merging
    /// with it, so specify the complete set of services that you want turned off.
    /// If you omit this field, the previous list is unchanged. To turn all services
    /// back on, specify an empty list.
    disabled_services: ?[]const []const u8 = null,

    /// Specifies whether ACK controllers resolve resource references to resources
    /// in a different Kubernetes namespace. Set this value to `false` to require
    /// references to remain within the same namespace, or `true` to allow
    /// cross-namespace references. If you omit this field, the current value is
    /// unchanged.
    enable_cross_namespace: ?bool = null,

    pub const json_field_names = .{
        .disabled_services = "disabledServices",
        .enable_cross_namespace = "enableCrossNamespace",
    };
};

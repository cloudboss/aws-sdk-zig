/// Information about the Kubernetes API for which you check if you have
/// permission to call.
pub const KubernetesPermissionCheckedDetails = struct {
    /// Information whether the user has the permission to call the Kubernetes API.
    allowed: ?bool = null,

    /// The namespace where the Kubernetes API action will take place.
    namespace: ?[]const u8 = null,

    /// The Kubernetes resource with which your Kubernetes API call will interact.
    resource: ?[]const u8 = null,

    /// The verb component of the Kubernetes API call. For example, when you check
    /// whether or not you have the permission to call the `CreatePod` API, the verb
    /// component will be `Create`.
    verb: ?[]const u8 = null,

    pub const json_field_names = .{
        .allowed = "Allowed",
        .namespace = "Namespace",
        .resource = "Resource",
        .verb = "Verb",
    };
};

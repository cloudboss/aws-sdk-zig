/// Contains information about the role binding that grants the permission
/// defined in a Kubernetes role.
pub const KubernetesRoleBindingDetails = struct {
    /// The kind of the role. For role binding, this value will be `RoleBinding`.
    kind: ?[]const u8 = null,

    /// The name of the `RoleBinding`.
    name: ?[]const u8 = null,

    /// The type of the role being referenced. This could be either `Role` or
    /// `ClusterRole`.
    role_ref_kind: ?[]const u8 = null,

    /// The name of the role being referenced. This must match the name of the
    /// `Role`
    /// or `ClusterRole` that you want to bind to.
    role_ref_name: ?[]const u8 = null,

    /// The unique identifier of the role binding.
    uid: ?[]const u8 = null,

    pub const json_field_names = .{
        .kind = "Kind",
        .name = "Name",
        .role_ref_kind = "RoleRefKind",
        .role_ref_name = "RoleRefName",
        .uid = "Uid",
    };
};

/// Information about the Kubernetes role name and role type.
pub const KubernetesRoleDetails = struct {
    /// The kind of role. For this API, the value of `kind` will be `Role`.
    kind: ?[]const u8 = null,

    /// The name of the Kubernetes role.
    name: ?[]const u8 = null,

    /// The unique identifier of the Kubernetes role name.
    uid: ?[]const u8 = null,

    pub const json_field_names = .{
        .kind = "Kind",
        .name = "Name",
        .uid = "Uid",
    };
};

/// The security context for a job. For more information, see [Configure a
/// security context for a pod or
/// container](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) in the *Kubernetes
/// documentation*.
pub const EksContainerSecurityContext = struct {
    /// Whether or not a container or a Kubernetes pod is allowed to gain more
    /// privileges than its parent
    /// process. The default value is `false`.
    allow_privilege_escalation: ?bool = null,

    /// When this parameter is `true`, the container is given elevated permissions
    /// on the
    /// host container instance. The level of permissions are similar to the `root`
    /// user
    /// permissions. The default value is `false`. This parameter maps to
    /// `privileged` policy in the [Privileged
    /// pod security
    /// policies](https://kubernetes.io/docs/concepts/security/pod-security-policy/#privileged) in the *Kubernetes documentation*.
    privileged: ?bool = null,

    /// When this parameter is `true`, the container is given read-only access to
    /// its
    /// root file system. The default value is `false`. This parameter maps to
    /// `ReadOnlyRootFilesystem` policy in the [Volumes and file systems pod
    /// security
    /// policies](https://kubernetes.io/docs/concepts/security/pod-security-policy/#volumes-and-file-systems) in the *Kubernetes
    /// documentation*.
    read_only_root_filesystem: ?bool = null,

    /// When this parameter is specified, the container is run as the specified
    /// group ID
    /// (`gid`). If this parameter isn't specified, the default is the group that's
    /// specified
    /// in the image metadata. This parameter maps to `RunAsGroup` and `MustRunAs`
    /// policy in the [Users
    /// and groups pod security
    /// policies](https://kubernetes.io/docs/concepts/security/pod-security-policy/#users-and-groups) in the *Kubernetes
    /// documentation*.
    run_as_group: ?i64 = null,

    /// When this parameter is specified, the container is run as a user with a
    /// `uid`
    /// other than 0. If this parameter isn't specified, so such rule is enforced.
    /// This parameter maps to
    /// `RunAsUser` and `MustRunAsNonRoot` policy in the [Users
    /// and groups pod security
    /// policies](https://kubernetes.io/docs/concepts/security/pod-security-policy/#users-and-groups) in the *Kubernetes
    /// documentation*.
    run_as_non_root: ?bool = null,

    /// When this parameter is specified, the container is run as the specified user
    /// ID
    /// (`uid`). If this parameter isn't specified, the default is the user that's
    /// specified
    /// in the image metadata. This parameter maps to `RunAsUser` and `MustRanAs`
    /// policy in the [Users
    /// and groups pod security
    /// policies](https://kubernetes.io/docs/concepts/security/pod-security-policy/#users-and-groups) in the *Kubernetes
    /// documentation*.
    run_as_user: ?i64 = null,

    pub const json_field_names = .{
        .allow_privilege_escalation = "allowPrivilegeEscalation",
        .privileged = "privileged",
        .read_only_root_filesystem = "readOnlyRootFilesystem",
        .run_as_group = "runAsGroup",
        .run_as_non_root = "runAsNonRoot",
        .run_as_user = "runAsUser",
    };
};

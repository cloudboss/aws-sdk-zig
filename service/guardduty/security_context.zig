/// Container security context.
pub const SecurityContext = struct {
    /// Whether or not a container or a Kubernetes pod is allowed to gain more
    /// privileges than its parent process.
    allow_privilege_escalation: ?bool,

    /// Whether the container is privileged.
    privileged: ?bool,

    pub const json_field_names = .{
        .allow_privilege_escalation = "AllowPrivilegeEscalation",
        .privileged = "Privileged",
    };
};

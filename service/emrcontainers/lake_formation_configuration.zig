const SecureNamespaceInfo = @import("secure_namespace_info.zig").SecureNamespaceInfo;

/// Lake Formation related configuration inputs for the security
/// configuration.
pub const LakeFormationConfiguration = struct {
    /// The session tag to authorize Amazon EMR on EKS for API calls to Lake
    /// Formation.
    authorized_session_tag_value: ?[]const u8,

    /// The query engine IAM role ARN that is tied to the secure Spark job. The
    /// `QueryEngine` role assumes the `JobExecutionRole` to execute all
    /// the Lake Formation calls.
    query_engine_role_arn: ?[]const u8,

    /// The namespace input of the system job.
    secure_namespace_info: ?SecureNamespaceInfo,

    pub const json_field_names = .{
        .authorized_session_tag_value = "authorizedSessionTagValue",
        .query_engine_role_arn = "queryEngineRoleArn",
        .secure_namespace_info = "secureNamespaceInfo",
    };
};

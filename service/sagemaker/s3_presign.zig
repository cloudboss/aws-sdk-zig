const IamPolicyConstraints = @import("iam_policy_constraints.zig").IamPolicyConstraints;

/// This object defines the access restrictions to Amazon S3 resources that are
/// included in custom worker task templates using the Liquid filter,
/// `grant_read_access`.
///
/// To learn more about how custom templates are created, see [Create custom
/// worker task
/// templates](https://docs.aws.amazon.com/sagemaker/latest/dg/a2i-custom-templates.html).
pub const S3Presign = struct {
    /// Use this parameter to specify the allowed request source. Possible sources
    /// are either `SourceIp` or `VpcSourceIp`.
    iam_policy_constraints: ?IamPolicyConstraints,

    pub const json_field_names = .{
        .iam_policy_constraints = "IamPolicyConstraints",
    };
};

const EnabledOrDisabled = @import("enabled_or_disabled.zig").EnabledOrDisabled;

/// Use this parameter to specify a supported global condition key that is added
/// to the IAM policy.
pub const IamPolicyConstraints = struct {
    /// When `SourceIp` is `Enabled` the worker's IP address when a task is rendered
    /// in the worker portal is added to the IAM policy as a `Condition` used to
    /// generate the Amazon S3 presigned URL. This IP address is checked by Amazon
    /// S3 and must match in order for the Amazon S3 resource to be rendered in the
    /// worker portal.
    source_ip: ?EnabledOrDisabled,

    /// When `VpcSourceIp` is `Enabled` the worker's IP address when a task is
    /// rendered in private worker portal inside the VPC is added to the IAM policy
    /// as a `Condition` used to generate the Amazon S3 presigned URL. To render the
    /// task successfully Amazon S3 checks that the presigned URL is being accessed
    /// over an Amazon S3 VPC Endpoint, and that the worker's IP address matches the
    /// IP address in the IAM policy. To learn more about configuring private worker
    /// portal, see [Use Amazon VPC mode from a private worker
    /// portal](https://docs.aws.amazon.com/sagemaker/latest/dg/samurai-vpc-worker-portal.html).
    vpc_source_ip: ?EnabledOrDisabled,

    pub const json_field_names = .{
        .source_ip = "SourceIp",
        .vpc_source_ip = "VpcSourceIp",
    };
};

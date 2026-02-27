const SupportType = @import("support_type.zig").SupportType;

/// The support policy to use for the cluster. Extended support allows you to
/// remain on
/// specific Kubernetes versions for longer. Clusters in extended support have
/// higher costs. The
/// default value is `EXTENDED`. Use `STANDARD` to disable extended
/// support.
///
/// [Learn more about EKS Extended Support in the *Amazon EKS User
/// Guide*.](https://docs.aws.amazon.com/eks/latest/userguide/extended-support-control.html)
pub const UpgradePolicyRequest = struct {
    /// If the cluster is set to `EXTENDED`, it will enter extended support at the
    /// end of standard support. If the cluster is set to `STANDARD`, it will be
    /// automatically upgraded at the end of standard support.
    ///
    /// [Learn more about EKS Extended Support in the *Amazon EKS User
    /// Guide*.](https://docs.aws.amazon.com/eks/latest/userguide/extended-support-control.html)
    support_type: ?SupportType,

    pub const json_field_names = .{
        .support_type = "supportType",
    };
};

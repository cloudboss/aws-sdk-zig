/// Configuration settings for an ACK (Amazon Web Services Controllers for
/// Kubernetes) capability. This includes whether controllers can resolve
/// cross-namespace resource references and which ACK service controllers are
/// disabled.
pub const AckConfigRequest = struct {
    /// A list of ACK service names whose controllers are turned off for this
    /// capability, for example `s3`, `ec2`, and `iam`. Resources of a disabled
    /// service aren't reconciled until you re-enable the service. To keep all
    /// services enabled, omit this field or specify an empty list. An unrecognized
    /// service name is accepted and stored but turns nothing off, and
    /// `DescribeCapability` returns the list exactly as you supplied it. For more
    /// information, see [ACK capability configuration
    /// options](https://docs.aws.amazon.com/eks/latest/userguide/create-ack-capability.html#ack-configuration-options) in the *Amazon EKS User Guide*.
    disabled_services: ?[]const []const u8 = null,

    /// Specifies whether ACK controllers resolve resource references to resources
    /// in a different Kubernetes namespace. Set this value to `true` to allow
    /// references to resolve to resources in another namespace. If you don't
    /// specify this value, or you omit the `ack` configuration entirely, the
    /// capability is created with this value set to `false` and references must
    /// remain within the same namespace.
    enable_cross_namespace: ?bool = null,

    pub const json_field_names = .{
        .disabled_services = "disabledServices",
        .enable_cross_namespace = "enableCrossNamespace",
    };
};

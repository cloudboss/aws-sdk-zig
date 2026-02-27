const IamIdentityCenterForGet = @import("iam_identity_center_for_get.zig").IamIdentityCenterForGet;

/// Contains details for the resource that provides identities to the identity
/// source. For example, an IAM Identity Center instance. For more information,
/// see [Identity
/// source](https://docs.aws.amazon.com/mpa/latest/userguide/mpa-concepts.html)
/// in the *Multi-party approval User Guide*.
pub const IdentitySourceParametersForGet = union(enum) {
    /// IAM Identity Center credentials.
    iam_identity_center: ?IamIdentityCenterForGet,

    pub const json_field_names = .{
        .iam_identity_center = "IamIdentityCenter",
    };
};

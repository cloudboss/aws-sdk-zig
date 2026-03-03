const IamIdentityCenter = @import("iam_identity_center.zig").IamIdentityCenter;

/// Contains details for the resource that provides identities to the identity
/// source. For example, an IAM Identity Center instance.
pub const IdentitySourceParameters = struct {
    /// IAM Identity Center credentials.
    iam_identity_center: ?IamIdentityCenter = null,

    pub const json_field_names = .{
        .iam_identity_center = "IamIdentityCenter",
    };
};

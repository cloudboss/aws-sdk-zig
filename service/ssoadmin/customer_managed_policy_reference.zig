/// Specifies the name and path of a customer managed policy. You must have an
/// IAM policy that matches the name and path in each Amazon Web Services
/// account where you want to deploy your permission set.
pub const CustomerManagedPolicyReference = struct {
    /// The name of the IAM policy that you have configured in each account where
    /// you want to deploy your permission set.
    name: []const u8,

    /// The path to the IAM policy that you have configured in each account where
    /// you want to deploy your permission set. The default is `/`. For more
    /// information, see [Friendly names and
    /// paths](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#identifiers-friendly-names) in the *IAM User Guide*.
    path: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
        .path = "Path",
    };
};

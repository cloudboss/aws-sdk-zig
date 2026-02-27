/// Provides the configuration information for the identifiers of your users.
pub const UserIdentityConfiguration = struct {
    /// The IAM Identity Center field name that contains the identifiers of your
    /// users,
    /// such as their emails. This is used for [user context
    /// filtering](https://docs.aws.amazon.com/kendra/latest/dg/user-context-filter.html)
    /// and for granting access to your Amazon Kendra experience. You must set up
    /// IAM Identity Center
    /// with Amazon Kendra. You must include your users and groups in your Access
    /// Control List when
    /// you ingest documents into your index. For more information, see
    /// [Getting
    /// started with an IAM Identity Center identity
    /// source](https://docs.aws.amazon.com/kendra/latest/dg/getting-started-aws-sso.html).
    identity_attribute_name: ?[]const u8,

    pub const json_field_names = .{
        .identity_attribute_name = "IdentityAttributeName",
    };
};

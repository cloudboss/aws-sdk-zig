/// Provides the SAML 2.0 compliant identity provider (IdP) configuration
/// information Amazon Q Business needs to deploy a Amazon Q Business web
/// experience.
pub const SamlConfiguration = struct {
    /// The metadata XML that your IdP generated.
    metadata_xml: []const u8,

    /// The Amazon Resource Name (ARN) of an IAM role assumed by users when they
    /// authenticate into their Amazon Q Business web experience, containing the
    /// relevant Amazon Q Business permissions for conversing with Amazon Q
    /// Business.
    role_arn: []const u8,

    /// The group attribute name in your IdP that maps to user groups.
    user_group_attribute: ?[]const u8,

    /// The user attribute name in your IdP that maps to the user email.
    user_id_attribute: []const u8,

    pub const json_field_names = .{
        .metadata_xml = "metadataXML",
        .role_arn = "roleArn",
        .user_group_attribute = "userGroupAttribute",
        .user_id_attribute = "userIdAttribute",
    };
};

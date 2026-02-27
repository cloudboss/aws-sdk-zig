/// Describes IAM federation options for an OpenSearch Serverless security
/// configuration in the form of a key-value map. These options define how
/// OpenSearch Serverless integrates with external identity providers using
/// federation.
pub const IamFederationConfigOptions = struct {
    /// The group attribute for this IAM federation integration. This attribute is
    /// used to map identity provider groups to OpenSearch Serverless permissions.
    group_attribute: ?[]const u8,

    /// The user attribute for this IAM federation integration. This attribute is
    /// used to identify users in the federated authentication process.
    user_attribute: ?[]const u8,

    pub const json_field_names = .{
        .group_attribute = "groupAttribute",
        .user_attribute = "userAttribute",
    };
};

/// The type of entity that a policy store maps to groups from an Amazon Cognito
/// user pool identity source.
///
/// This data type is part of an
/// [CognitoUserPoolConfigurationItem](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_CognitoUserPoolConfigurationDetail.html) structure and is a response parameter to [ListIdentitySources](http://forums.aws.amazon.com/verifiedpermissions/latest/apireference/API_ListIdentitySources.html).
pub const CognitoGroupConfigurationItem = struct {
    /// The name of the schema entity type that's mapped to the user pool group.
    /// Defaults to `AWS::CognitoGroup`.
    group_entity_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .group_entity_type = "groupEntityType",
    };
};

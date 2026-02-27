/// The type of entity that a policy store maps to groups from an Amazon Cognito
/// user pool identity source.
///
/// This data type is part of a
/// [CognitoUserPoolConfiguration](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_CognitoUserPoolConfiguration.html) structure and is a request parameter in [CreateIdentitySource](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_CreateIdentitySource.html).
pub const CognitoGroupConfiguration = struct {
    /// The name of the schema entity type that's mapped to the user pool group.
    /// Defaults to `AWS::CognitoGroup`.
    group_entity_type: []const u8,

    pub const json_field_names = .{
        .group_entity_type = "groupEntityType",
    };
};

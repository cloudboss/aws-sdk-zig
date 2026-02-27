/// The user group entities from an Amazon Cognito user pool identity source.
pub const UpdateCognitoGroupConfiguration = struct {
    /// The name of the schema entity type that's mapped to the user pool group.
    /// Defaults to `AWS::CognitoGroup`.
    group_entity_type: []const u8,

    pub const json_field_names = .{
        .group_entity_type = "groupEntityType",
    };
};

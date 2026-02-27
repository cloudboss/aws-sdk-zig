const AttributeDataType = @import("attribute_data_type.zig").AttributeDataType;
const NumberAttributeConstraintsType = @import("number_attribute_constraints_type.zig").NumberAttributeConstraintsType;
const StringAttributeConstraintsType = @import("string_attribute_constraints_type.zig").StringAttributeConstraintsType;

/// A list of the user attributes and their properties in your user pool. The
/// attribute
/// schema contains standard attributes, custom attributes with a `custom:`
/// prefix, and developer attributes with a `dev:` prefix. For more information,
/// see [User pool
/// attributes](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-attributes.html).
///
/// Developer-only `dev:` attributes are a legacy feature of user pools, and
/// are read-only to all app clients. You can create and update developer-only
/// attributes
/// only with IAM-authenticated API operations. Use app client read/write
/// permissions
/// instead.
pub const SchemaAttributeType = struct {
    /// The data format of the values for your attribute. When you choose an
    /// `AttributeDataType`, Amazon Cognito validates the input against the data
    /// type. A
    /// custom attribute value in your user's ID token is always a string, for
    /// example
    /// `"custom:isMember" : "true"` or `"custom:YearsAsMember" :
    /// "12"`.
    attribute_data_type: ?AttributeDataType,

    /// You should use
    /// [WriteAttributes](https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_UserPoolClientType.html#CognitoUserPools-Type-UserPoolClientType-WriteAttributes) in the user pool client to control how attributes can
    /// be mutated for new use cases instead of using
    /// `DeveloperOnlyAttribute`.
    ///
    /// Specifies whether the attribute type is developer only. This attribute can
    /// only be
    /// modified by an administrator. Users won't be able to modify this attribute
    /// using their
    /// access token. For example, `DeveloperOnlyAttribute` can be modified using
    /// AdminUpdateUserAttributes but can't be updated using UpdateUserAttributes.
    developer_only_attribute: ?bool,

    /// Specifies whether the value of the attribute can be changed.
    ///
    /// Any user pool attribute whose value you map from an IdP attribute must be
    /// mutable,
    /// with a parameter value of `true`. Amazon Cognito updates mapped attributes
    /// when users
    /// sign in to your application through an IdP. If an attribute is immutable,
    /// Amazon Cognito throws
    /// an error when it attempts to update the attribute. For more information, see
    /// [Specifying Identity Provider Attribute Mappings for Your User
    /// Pool](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-specifying-attribute-mapping.html).
    mutable: ?bool,

    /// The name of your user pool attribute. When you create or update a user pool,
    /// adding a
    /// schema attribute creates a custom or developer-only attribute. When you add
    /// an attribute
    /// with a `Name` value of `MyAttribute`, Amazon Cognito creates the custom
    /// attribute `custom:MyAttribute`. When `DeveloperOnlyAttribute` is
    /// `true`, Amazon Cognito creates your attribute as `dev:MyAttribute`. In
    /// an operation that describes a user pool, Amazon Cognito returns this value
    /// as `value`
    /// for standard attributes, `custom:value` for custom attributes, and
    /// `dev:value` for developer-only attributes..
    name: ?[]const u8,

    /// Specifies the constraints for an attribute of the number type.
    number_attribute_constraints: ?NumberAttributeConstraintsType,

    /// Specifies whether a user pool attribute is required. If the attribute is
    /// required and
    /// the user doesn't provide a value, registration or sign-in will fail.
    required: ?bool,

    /// Specifies the constraints for an attribute of the string type.
    string_attribute_constraints: ?StringAttributeConstraintsType,

    pub const json_field_names = .{
        .attribute_data_type = "AttributeDataType",
        .developer_only_attribute = "DeveloperOnlyAttribute",
        .mutable = "Mutable",
        .name = "Name",
        .number_attribute_constraints = "NumberAttributeConstraints",
        .required = "Required",
        .string_attribute_constraints = "StringAttributeConstraints",
    };
};

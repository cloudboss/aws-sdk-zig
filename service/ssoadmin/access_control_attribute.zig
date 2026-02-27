const AccessControlAttributeValue = @import("access_control_attribute_value.zig").AccessControlAttributeValue;

/// These are IAM Identity Center identity store attributes that you can
/// configure for use in attributes-based access control (ABAC). You can create
/// permissions policies that determine who can access your Amazon Web Services
/// resources based upon the configured attribute values. When you enable ABAC
/// and specify `AccessControlAttributes`, IAM Identity Center passes the
/// attribute values of the authenticated user into IAM for use in policy
/// evaluation.
pub const AccessControlAttribute = struct {
    /// The name of the attribute associated with your identities in your identity
    /// source. This is used to map a specified attribute in your identity source
    /// with an attribute in IAM Identity Center.
    key: []const u8,

    /// The value used for mapping a specified attribute to an identity source.
    value: AccessControlAttributeValue,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};

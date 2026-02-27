/// The value used for mapping a specified attribute to an identity source. For
/// more information, see [Attribute
/// mappings](https://docs.aws.amazon.com/singlesignon/latest/userguide/attributemappingsconcept.html) in the *IAM Identity Center User Guide*.
pub const AccessControlAttributeValue = struct {
    /// The identity source to use when mapping a specified attribute to IAM
    /// Identity Center.
    source: []const []const u8,

    pub const json_field_names = .{
        .source = "Source",
    };
};

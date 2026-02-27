/// Provides the configuration information for the JSON token type.
pub const JsonTokenTypeConfiguration = struct {
    /// The group attribute field.
    group_attribute_field: []const u8,

    /// The user name attribute field.
    user_name_attribute_field: []const u8,

    pub const json_field_names = .{
        .group_attribute_field = "GroupAttributeField",
        .user_name_attribute_field = "UserNameAttributeField",
    };
};

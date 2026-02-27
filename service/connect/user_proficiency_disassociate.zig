/// Information about proficiency to be disassociated from the user.
pub const UserProficiencyDisassociate = struct {
    /// The name of user's proficiency.
    attribute_name: []const u8,

    /// The value of user's proficiency.
    attribute_value: []const u8,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .attribute_value = "AttributeValue",
    };
};

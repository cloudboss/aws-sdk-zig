/// Information about proficiency of a user.
pub const UserProficiency = struct {
    /// The name of user's proficiency. You must use name of predefined attribute
    /// present in the Amazon Connect instance.
    attribute_name: []const u8,

    /// The value of user's proficiency. You must use value of predefined attribute
    /// present in the Amazon Connect
    /// instance.
    attribute_value: []const u8,

    /// The level of the proficiency. The valid values are 1, 2, 3, 4 and 5.
    level: f32 = 1,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .attribute_value = "AttributeValue",
        .level = "Level",
    };
};

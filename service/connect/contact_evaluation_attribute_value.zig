/// The value of a contact evaluation attribute condition.
pub const ContactEvaluationAttributeValue = struct {
    /// A string value for the attribute.
    string_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .string_value = "StringValue",
    };
};

const aws = @import("aws");

/// Information about the template attributes.
pub const TemplateAttributes = struct {
    /// An object that specifies the custom attributes values to use for variables
    /// in the message template. This object
    /// contains different categories of key-value pairs. Each key defines a
    /// variable or placeholder in the message template.
    custom_attributes: ?[]const aws.map.StringMapEntry,

    /// An object that specifies the customer profile attributes values to use for
    /// variables in the message template.
    /// This object contains different categories of key-value pairs. Each key
    /// defines a variable or placeholder in the
    /// message template.
    customer_profile_attributes: ?[]const u8,

    pub const json_field_names = .{
        .custom_attributes = "CustomAttributes",
        .customer_profile_attributes = "CustomerProfileAttributes",
    };
};

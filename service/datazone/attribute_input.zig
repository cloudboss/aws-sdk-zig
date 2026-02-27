const FormInput = @import("form_input.zig").FormInput;

/// The attribute input.
pub const AttributeInput = struct {
    /// The ID of the attribute.
    attribute_identifier: []const u8,

    /// The metadata forms as part of the attribute input.
    forms: []const FormInput,

    pub const json_field_names = .{
        .attribute_identifier = "attributeIdentifier",
        .forms = "forms",
    };
};

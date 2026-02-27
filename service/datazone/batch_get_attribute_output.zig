const FormOutput = @import("form_output.zig").FormOutput;

/// The results of the BatchGetAttribute action.
pub const BatchGetAttributeOutput = struct {
    /// The attribute ID.
    attribute_identifier: []const u8,

    /// The metadata forms that are part of the results of the BatchGetAttribute
    /// action.
    forms: ?[]const FormOutput,

    pub const json_field_names = .{
        .attribute_identifier = "attributeIdentifier",
        .forms = "forms",
    };
};

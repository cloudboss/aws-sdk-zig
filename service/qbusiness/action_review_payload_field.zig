const ActionReviewPayloadFieldAllowedValue = @import("action_review_payload_field_allowed_value.zig").ActionReviewPayloadFieldAllowedValue;
const ActionPayloadFieldType = @import("action_payload_field_type.zig").ActionPayloadFieldType;

/// A user input field in an plugin action review payload.
pub const ActionReviewPayloadField = struct {
    /// The expected data format for the action review input field value. For
    /// example, in PTO request, `from` and `to` would be of `datetime` allowed
    /// format.
    allowed_format: ?[]const u8 = null,

    /// Information about the field values that an end user can use to provide to
    /// Amazon Q Business for Amazon Q Business to perform the requested plugin
    /// action.
    allowed_values: ?[]const ActionReviewPayloadFieldAllowedValue = null,

    /// Use to create a custom form with array fields (fields with nested objects
    /// inside an array).
    array_item_json_schema: ?[]const u8 = null,

    /// The field level description of each action review input field. This could be
    /// an explanation of the field. In the Amazon Q Business web experience, these
    /// descriptions could be used to display as tool tips to help users understand
    /// the field.
    display_description: ?[]const u8 = null,

    /// The name of the field.
    display_name: ?[]const u8 = null,

    /// The display order of fields in a payload.
    display_order: ?i32 = null,

    /// Information about whether the field is required.
    required: ?bool = null,

    /// The type of field.
    @"type": ?ActionPayloadFieldType = null,

    /// The field value.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .allowed_format = "allowedFormat",
        .allowed_values = "allowedValues",
        .array_item_json_schema = "arrayItemJsonSchema",
        .display_description = "displayDescription",
        .display_name = "displayName",
        .display_order = "displayOrder",
        .required = "required",
        .@"type" = "type",
        .value = "value",
    };
};

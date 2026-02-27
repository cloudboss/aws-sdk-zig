/// Information about the field values that an end user can use to provide to
/// Amazon Q Business for Amazon Q Business to perform the requested plugin
/// action.
pub const ActionReviewPayloadFieldAllowedValue = struct {
    /// The name of the field.
    display_value: ?[]const u8,

    /// The field value.
    value: ?[]const u8,

    pub const json_field_names = .{
        .display_value = "displayValue",
        .value = "value",
    };
};

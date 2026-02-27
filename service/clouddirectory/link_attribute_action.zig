const UpdateActionType = @import("update_action_type.zig").UpdateActionType;
const TypedAttributeValue = @import("typed_attribute_value.zig").TypedAttributeValue;

/// The action to take on a typed link attribute value. Updates are only
/// supported for attributes which don’t contribute to link identity.
pub const LinkAttributeAction = struct {
    /// A type that can be either `UPDATE_OR_CREATE` or `DELETE`.
    attribute_action_type: ?UpdateActionType,

    /// The value that you want to update to.
    attribute_update_value: ?TypedAttributeValue,

    pub const json_field_names = .{
        .attribute_action_type = "AttributeActionType",
        .attribute_update_value = "AttributeUpdateValue",
    };
};

const UpdateActionType = @import("update_action_type.zig").UpdateActionType;
const TypedAttributeValue = @import("typed_attribute_value.zig").TypedAttributeValue;

/// The action to take on the object attribute.
pub const ObjectAttributeAction = struct {
    /// A type that can be either `Update` or `Delete`.
    object_attribute_action_type: ?UpdateActionType,

    /// The value that you want to update to.
    object_attribute_update_value: ?TypedAttributeValue,

    pub const json_field_names = .{
        .object_attribute_action_type = "ObjectAttributeActionType",
        .object_attribute_update_value = "ObjectAttributeUpdateValue",
    };
};

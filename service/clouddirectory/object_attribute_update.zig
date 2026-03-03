const ObjectAttributeAction = @import("object_attribute_action.zig").ObjectAttributeAction;
const AttributeKey = @import("attribute_key.zig").AttributeKey;

/// Structure that contains attribute update information.
pub const ObjectAttributeUpdate = struct {
    /// The action to perform as part of the attribute update.
    object_attribute_action: ?ObjectAttributeAction = null,

    /// The key of the attribute being updated.
    object_attribute_key: ?AttributeKey = null,

    pub const json_field_names = .{
        .object_attribute_action = "ObjectAttributeAction",
        .object_attribute_key = "ObjectAttributeKey",
    };
};

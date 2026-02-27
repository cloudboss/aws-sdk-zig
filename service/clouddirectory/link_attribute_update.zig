const LinkAttributeAction = @import("link_attribute_action.zig").LinkAttributeAction;
const AttributeKey = @import("attribute_key.zig").AttributeKey;

/// Structure that contains attribute update information.
pub const LinkAttributeUpdate = struct {
    /// The action to perform as part of the attribute update.
    attribute_action: ?LinkAttributeAction,

    /// The key of the attribute being updated.
    attribute_key: ?AttributeKey,

    pub const json_field_names = .{
        .attribute_action = "AttributeAction",
        .attribute_key = "AttributeKey",
    };
};

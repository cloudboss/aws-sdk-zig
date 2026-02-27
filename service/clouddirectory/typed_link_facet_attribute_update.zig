const UpdateActionType = @import("update_action_type.zig").UpdateActionType;
const TypedLinkAttributeDefinition = @import("typed_link_attribute_definition.zig").TypedLinkAttributeDefinition;

/// A typed link facet attribute update.
pub const TypedLinkFacetAttributeUpdate = struct {
    /// The action to perform when updating the attribute.
    action: UpdateActionType,

    /// The attribute to update.
    attribute: TypedLinkAttributeDefinition,

    pub const json_field_names = .{
        .action = "Action",
        .attribute = "Attribute",
    };
};

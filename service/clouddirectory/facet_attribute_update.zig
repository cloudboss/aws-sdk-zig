const UpdateActionType = @import("update_action_type.zig").UpdateActionType;
const FacetAttribute = @import("facet_attribute.zig").FacetAttribute;

/// A structure that contains information used to update an attribute.
pub const FacetAttributeUpdate = struct {
    /// The action to perform when updating the attribute.
    action: ?UpdateActionType = null,

    /// The attribute to update.
    attribute: ?FacetAttribute = null,

    pub const json_field_names = .{
        .action = "Action",
        .attribute = "Attribute",
    };
};

const CustomLineItemRelationship = @import("custom_line_item_relationship.zig").CustomLineItemRelationship;

/// A filter that specifies the type of resource associations that should be
/// retrieved for a custom line item.
pub const ListResourcesAssociatedToCustomLineItemFilter = struct {
    /// The type of relationship between the custom line item and the associated
    /// resource.
    relationship: ?CustomLineItemRelationship = null,

    pub const json_field_names = .{
        .relationship = "Relationship",
    };
};

const TypedLinkAttributeDefinition = @import("typed_link_attribute_definition.zig").TypedLinkAttributeDefinition;

/// Defines the typed links structure and its attributes. To create a typed link
/// facet, use
/// the CreateTypedLinkFacet API.
pub const TypedLinkFacet = struct {
    /// A set of key-value pairs associated with the typed link. Typed link
    /// attributes are used when you have data values that are related to the link
    /// itself, and not to one of the two objects being linked. Identity attributes
    /// also serve to distinguish the link from others of the same type between the
    /// same objects.
    attributes: []const TypedLinkAttributeDefinition,

    /// The set of attributes that distinguish links made from this facet from each
    /// other, in the order of significance. Listing typed links can filter on the
    /// values of these attributes. See ListOutgoingTypedLinks and
    /// ListIncomingTypedLinks for details.
    identity_attribute_order: []const []const u8,

    /// The unique name of the typed link facet.
    name: []const u8,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .identity_attribute_order = "IdentityAttributeOrder",
        .name = "Name",
    };
};

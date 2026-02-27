const AttributeNameAndValue = @import("attribute_name_and_value.zig").AttributeNameAndValue;
const ObjectReference = @import("object_reference.zig").ObjectReference;
const TypedLinkSchemaAndFacetName = @import("typed_link_schema_and_facet_name.zig").TypedLinkSchemaAndFacetName;

/// Contains all the information that is used to uniquely identify a typed link.
/// The
/// parameters discussed in this topic are used to uniquely specify the typed
/// link being operated
/// on. The AttachTypedLink API returns a typed link specifier while the
/// DetachTypedLink API accepts one as input. Similarly, the
/// ListIncomingTypedLinks and ListOutgoingTypedLinks API
/// operations provide typed link specifiers as output. You can also construct a
/// typed link
/// specifier from scratch.
pub const TypedLinkSpecifier = struct {
    /// Identifies the attribute value to update.
    identity_attribute_values: []const AttributeNameAndValue,

    /// Identifies the source object that the typed link will attach to.
    source_object_reference: ObjectReference,

    /// Identifies the target object that the typed link will attach to.
    target_object_reference: ObjectReference,

    /// Identifies the typed link facet that is associated with the typed link.
    typed_link_facet: TypedLinkSchemaAndFacetName,

    pub const json_field_names = .{
        .identity_attribute_values = "IdentityAttributeValues",
        .source_object_reference = "SourceObjectReference",
        .target_object_reference = "TargetObjectReference",
        .typed_link_facet = "TypedLinkFacet",
    };
};

const AttributeNameAndValue = @import("attribute_name_and_value.zig").AttributeNameAndValue;
const ObjectReference = @import("object_reference.zig").ObjectReference;
const TypedLinkSchemaAndFacetName = @import("typed_link_schema_and_facet_name.zig").TypedLinkSchemaAndFacetName;

/// Attaches a typed link to a specified source and target object inside a
/// BatchRead operation. For more information, see AttachTypedLink and
/// BatchReadRequest$Operations.
pub const BatchAttachTypedLink = struct {
    /// A set of attributes that are associated with the typed link.
    attributes: []const AttributeNameAndValue,

    /// Identifies the source object that the typed link will attach to.
    source_object_reference: ObjectReference,

    /// Identifies the target object that the typed link will attach to.
    target_object_reference: ObjectReference,

    /// Identifies the typed link facet that is associated with the typed link.
    typed_link_facet: TypedLinkSchemaAndFacetName,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .source_object_reference = "SourceObjectReference",
        .target_object_reference = "TargetObjectReference",
        .typed_link_facet = "TypedLinkFacet",
    };
};

const AttributeKeyAndValue = @import("attribute_key_and_value.zig").AttributeKeyAndValue;
const ObjectReference = @import("object_reference.zig").ObjectReference;
const SchemaFacet = @import("schema_facet.zig").SchemaFacet;

/// Represents the output of a CreateObject operation.
pub const BatchCreateObject = struct {
    /// The batch reference name. See [Transaction
    /// Support](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/transaction_support.html) for more information.
    batch_reference_name: ?[]const u8 = null,

    /// The name of the link.
    link_name: ?[]const u8 = null,

    /// An attribute map, which contains an attribute ARN as the key and attribute
    /// value as
    /// the map value.
    object_attribute_list: []const AttributeKeyAndValue,

    /// If specified, the parent reference to which this object will be attached.
    parent_reference: ?ObjectReference = null,

    /// A list of `FacetArns` that will be associated with the object. For more
    /// information, see arns.
    schema_facet: []const SchemaFacet,

    pub const json_field_names = .{
        .batch_reference_name = "BatchReferenceName",
        .link_name = "LinkName",
        .object_attribute_list = "ObjectAttributeList",
        .parent_reference = "ParentReference",
        .schema_facet = "SchemaFacet",
    };
};

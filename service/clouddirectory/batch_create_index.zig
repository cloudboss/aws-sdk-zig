const AttributeKey = @import("attribute_key.zig").AttributeKey;
const ObjectReference = @import("object_reference.zig").ObjectReference;

/// Creates an index object inside of a BatchRead operation. For more
/// information, see CreateIndex and BatchReadRequest$Operations.
pub const BatchCreateIndex = struct {
    /// The batch reference name. See [Transaction
    /// Support](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/transaction_support.html) for more information.
    batch_reference_name: ?[]const u8 = null,

    /// Indicates whether the attribute that is being indexed has unique values or
    /// not.
    is_unique: bool = false,

    /// The name of the link between the parent object and the index object.
    link_name: ?[]const u8 = null,

    /// Specifies the attributes that should be indexed on. Currently only a single
    /// attribute
    /// is supported.
    ordered_indexed_attribute_list: []const AttributeKey,

    /// A reference to the parent object that contains the index object.
    parent_reference: ?ObjectReference = null,

    pub const json_field_names = .{
        .batch_reference_name = "BatchReferenceName",
        .is_unique = "IsUnique",
        .link_name = "LinkName",
        .ordered_indexed_attribute_list = "OrderedIndexedAttributeList",
        .parent_reference = "ParentReference",
    };
};

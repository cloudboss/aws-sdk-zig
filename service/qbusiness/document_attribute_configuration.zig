const Status = @import("status.zig").Status;
const AttributeType = @import("attribute_type.zig").AttributeType;

/// Configuration information for document attributes. Document attributes are
/// metadata or fields associated with your documents. For example, the company
/// department name associated with each document.
///
/// For more information, see [Understanding document
/// attributes](https://docs.aws.amazon.com/amazonq/latest/business-use-dg/doc-attributes.html).
pub const DocumentAttributeConfiguration = struct {
    /// The name of the document attribute.
    name: ?[]const u8 = null,

    /// Information about whether the document attribute can be used by an end user
    /// to search for information on their web experience.
    search: ?Status = null,

    /// The type of document attribute.
    @"type": ?AttributeType = null,

    pub const json_field_names = .{
        .name = "name",
        .search = "search",
        .@"type" = "type",
    };
};

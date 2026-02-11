const KeySchemaElement = @import("key_schema_element.zig").KeySchemaElement;
const Projection = @import("projection.zig").Projection;

/// Represents the properties of a local secondary index for the table when the
/// backup was
/// created.
pub const LocalSecondaryIndexInfo = struct {
    /// Represents the name of the local secondary index.
    index_name: ?[]const u8,

    /// The complete key schema for a local secondary index, which consists of one
    /// or more
    /// pairs of attribute names and key types:
    ///
    /// * `HASH` - partition key
    ///
    /// * `RANGE` - sort key
    ///
    /// **Note:**
    ///
    /// The partition key of an item is also known as its *hash
    /// attribute*. The term "hash attribute" derives from DynamoDB's usage of
    /// an internal hash function to evenly distribute data items across partitions,
    /// based
    /// on their partition key values.
    ///
    /// The sort key of an item is also known as its *range attribute*.
    /// The term "range attribute" derives from the way DynamoDB stores items with
    /// the same
    /// partition key physically close together, in sorted order by the sort key
    /// value.
    key_schema: ?[]const KeySchemaElement,

    /// Represents attributes that are copied (projected) from the table into the
    /// global
    /// secondary index. These are in addition to the primary key attributes and
    /// index key
    /// attributes, which are automatically projected.
    projection: ?Projection,

    pub const json_field_names = .{
        .index_name = "IndexName",
        .key_schema = "KeySchema",
        .projection = "Projection",
    };
};

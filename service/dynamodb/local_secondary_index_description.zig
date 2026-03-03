const KeySchemaElement = @import("key_schema_element.zig").KeySchemaElement;
const Projection = @import("projection.zig").Projection;

/// Represents the properties of a local secondary index.
pub const LocalSecondaryIndexDescription = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies the index.
    index_arn: ?[]const u8 = null,

    /// Represents the name of the local secondary index.
    index_name: ?[]const u8 = null,

    /// The total size of the specified index, in bytes. DynamoDB updates this value
    /// approximately every six hours. Recent changes might not be reflected in this
    /// value.
    index_size_bytes: ?i64 = null,

    /// The number of items in the specified index. DynamoDB updates this value
    /// approximately every six hours. Recent changes might not be reflected in this
    /// value.
    item_count: ?i64 = null,

    /// The complete key schema for the local secondary index, consisting of one or
    /// more pairs
    /// of attribute names and key types:
    ///
    /// * `HASH` - partition key
    ///
    /// * `RANGE` - sort key
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
    key_schema: ?[]const KeySchemaElement = null,

    /// Represents attributes that are copied (projected) from the table into the
    /// global
    /// secondary index. These are in addition to the primary key attributes and
    /// index key
    /// attributes, which are automatically projected.
    projection: ?Projection = null,

    pub const json_field_names = .{
        .index_arn = "IndexArn",
        .index_name = "IndexName",
        .index_size_bytes = "IndexSizeBytes",
        .item_count = "ItemCount",
        .key_schema = "KeySchema",
        .projection = "Projection",
    };
};

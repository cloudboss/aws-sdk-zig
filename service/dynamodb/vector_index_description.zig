const VectorDistanceFunction = @import("vector_distance_function.zig").VectorDistanceFunction;
const IndexStatus = @import("index_status.zig").IndexStatus;
const Projection = @import("projection.zig").Projection;
const SearchSchemaElement = @import("search_schema_element.zig").SearchSchemaElement;
const VectorAttributeDefinition = @import("vector_attribute_definition.zig").VectorAttributeDefinition;

/// Contains the current state and configuration of a vector index, including
/// its
/// status, size, item count, and the settings specified when the index was
/// created.
pub const VectorIndexDescription = struct {
    /// Specifies whether the index is currently backfilling. During backfill,
    /// `SearchVectors` operations might return incomplete results.
    backfilling: ?bool = null,

    /// The number of dimensions in each vector.
    dimensions: ?i64 = null,

    /// The distance function used to calculate similarity between vectors.
    distance_function: ?VectorDistanceFunction = null,

    /// The Amazon Resource Name (ARN) that uniquely identifies the vector index.
    index_arn: ?[]const u8 = null,

    /// The name of the vector index.
    index_name: ?[]const u8 = null,

    /// The total size of the vector index, in bytes. Amazon DynamoDB updates this
    /// value
    /// approximately every six hours. Recent changes might not be reflected in this
    /// value.
    index_size_bytes: ?i64 = null,

    /// The current state of the vector index:
    ///
    /// * `CREATING` - The index is being created.
    ///
    /// * `ACTIVE` - The index is ready for use.
    ///
    /// * `DELETING` - The index is being deleted.
    index_status: ?IndexStatus = null,

    /// The number of items indexed in the vector index. Amazon DynamoDB updates
    /// this
    /// value approximately every six hours. Recent changes might not be reflected
    /// in
    /// this value.
    item_count: ?i64 = null,

    /// Specifies attributes that are copied (projected) from the table into the
    /// vector
    /// index.
    projection: ?Projection = null,

    /// The search schema that defines partition key and inline filter attributes
    /// for
    /// the vector index.
    search_schema: ?[]const SearchSchemaElement = null,

    /// The vector attribute configuration for the index.
    vector_attribute: ?VectorAttributeDefinition = null,

    pub const json_field_names = .{
        .backfilling = "Backfilling",
        .dimensions = "Dimensions",
        .distance_function = "DistanceFunction",
        .index_arn = "IndexArn",
        .index_name = "IndexName",
        .index_size_bytes = "IndexSizeBytes",
        .index_status = "IndexStatus",
        .item_count = "ItemCount",
        .projection = "Projection",
        .search_schema = "SearchSchema",
        .vector_attribute = "VectorAttribute",
    };
};

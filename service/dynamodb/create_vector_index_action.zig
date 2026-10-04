const VectorDistanceFunction = @import("vector_distance_function.zig").VectorDistanceFunction;
const Projection = @import("projection.zig").Projection;
const SearchSchemaElement = @import("search_schema_element.zig").SearchSchemaElement;
const VectorAttributeDefinition = @import("vector_attribute_definition.zig").VectorAttributeDefinition;

/// A new vector index to be added to a table.
pub const CreateVectorIndexAction = struct {
    /// The number of dimensions in each vector.
    dimensions: i64,

    /// The distance function used to calculate similarity. Valid values:
    /// `COSINE`, `EUCLIDEAN`, `DOT_PRODUCT`.
    distance_function: VectorDistanceFunction,

    /// The name of the vector index. Must be unique within the table.
    index_name: []const u8,

    /// Specifies attributes that are copied (projected) from the table into the
    /// vector
    /// index.
    projection: Projection,

    /// The partition key and inline filter attribute definitions for the vector
    /// index.
    search_schema: ?[]const SearchSchemaElement = null,

    /// The attribute that contains vector embeddings. If multiple vector indexes
    /// reference the same attribute, they must all use the same number of
    /// dimensions.
    vector_attribute: VectorAttributeDefinition,

    pub const json_field_names = .{
        .dimensions = "Dimensions",
        .distance_function = "DistanceFunction",
        .index_name = "IndexName",
        .projection = "Projection",
        .search_schema = "SearchSchema",
        .vector_attribute = "VectorAttribute",
    };
};

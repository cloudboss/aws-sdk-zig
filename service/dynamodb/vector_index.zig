const VectorDistanceFunction = @import("vector_distance_function.zig").VectorDistanceFunction;
const Projection = @import("projection.zig").Projection;
const SearchSchemaElement = @import("search_schema_element.zig").SearchSchemaElement;
const VectorAttributeDefinition = @import("vector_attribute_definition.zig").VectorAttributeDefinition;

/// Contains the configuration settings for a vector index, including the index
/// name,
/// vector attribute, dimensions, distance function, search schema, and
/// projection.
pub const VectorIndex = struct {
    /// The number of dimensions in each vector.
    dimensions: i64,

    /// The distance function used to calculate similarity between vectors. Valid
    /// values:
    /// `COSINE`, `EUCLIDEAN`, `DOT_PRODUCT`.
    distance_function: VectorDistanceFunction,

    /// The name of the vector index.
    index_name: []const u8,

    /// Specifies attributes that are copied (projected) from the table into the
    /// vector
    /// index.
    projection: Projection,

    /// The search schema that defines partition key and inline filter attributes
    /// for
    /// the vector index.
    search_schema: ?[]const SearchSchemaElement = null,

    /// The vector attribute configuration for the index.
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

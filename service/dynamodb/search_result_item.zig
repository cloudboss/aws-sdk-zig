const aws = @import("aws");

const AttributeValue = @import("attribute_value.zig").AttributeValue;

/// A single result from a `SearchVectors` operation.
pub const SearchResultItem = struct {
    /// A map of attribute names to `AttributeValue` objects, representing the
    /// projected attributes of the item returned by the vector search.
    item: ?[]const aws.map.MapEntry(AttributeValue) = null,

    /// The similarity score for this item relative to the search vector. The
    /// interpretation depends on the distance function configured for the vector
    /// index.
    score: f64 = 0,

    pub const json_field_names = .{
        .item = "Item",
        .score = "Score",
    };
};

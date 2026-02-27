/// A single product view aggregation value/count pair, containing metadata
/// about each
/// product to which the calling user has access.
pub const ProductViewAggregationValue = struct {
    /// An approximate count of the products that match the value.
    approximate_count: i32 = 0,

    /// The value of the product view aggregation.
    value: ?[]const u8,

    pub const json_field_names = .{
        .approximate_count = "ApproximateCount",
        .value = "Value",
    };
};

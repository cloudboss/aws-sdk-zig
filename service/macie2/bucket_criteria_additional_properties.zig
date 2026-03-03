/// Specifies the operator to use in a property-based condition that filters the
/// results of a query for information about S3 buckets.
pub const BucketCriteriaAdditionalProperties = struct {
    /// The value for the property matches (equals) the specified value. If you
    /// specify multiple values, Amazon Macie uses OR logic to join the values.
    eq: ?[]const []const u8 = null,

    /// The value for the property is greater than the specified value.
    gt: ?i64 = null,

    /// The value for the property is greater than or equal to the specified value.
    gte: ?i64 = null,

    /// The value for the property is less than the specified value.
    lt: ?i64 = null,

    /// The value for the property is less than or equal to the specified value.
    lte: ?i64 = null,

    /// The value for the property doesn't match (doesn't equal) the specified
    /// value. If you specify multiple values, Amazon Macie uses OR logic to join
    /// the values.
    neq: ?[]const []const u8 = null,

    /// The name of the bucket begins with the specified value.
    prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .eq = "eq",
        .gt = "gt",
        .gte = "gte",
        .lt = "lt",
        .lte = "lte",
        .neq = "neq",
        .prefix = "prefix",
    };
};

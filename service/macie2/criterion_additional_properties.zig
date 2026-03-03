/// Specifies the operator to use in a property-based condition that filters the
/// results of a query for findings. For detailed information and examples of
/// each operator, see [Fundamentals of filtering
/// findings](https://docs.aws.amazon.com/macie/latest/user/findings-filter-basics.html) in the *Amazon Macie User Guide*.
pub const CriterionAdditionalProperties = struct {
    /// The value for the property matches (equals) the specified value. If you
    /// specify multiple values, Macie uses OR logic to join the values.
    eq: ?[]const []const u8 = null,

    /// The value for the property exclusively matches (equals an exact match for)
    /// all the specified values. If you specify multiple values, Amazon Macie uses
    /// AND logic to join the values.
    ///
    /// You can use this operator with the following properties:
    /// customDataIdentifiers.detections.arn, customDataIdentifiers.detections.name,
    /// resourcesAffected.s3Bucket.tags.key, resourcesAffected.s3Bucket.tags.value,
    /// resourcesAffected.s3Object.tags.key, resourcesAffected.s3Object.tags.value,
    /// sensitiveData.category, and sensitiveData.detections.type.
    eq_exact_match: ?[]const []const u8 = null,

    /// The value for the property is greater than the specified value.
    gt: ?i64 = null,

    /// The value for the property is greater than or equal to the specified value.
    gte: ?i64 = null,

    /// The value for the property is less than the specified value.
    lt: ?i64 = null,

    /// The value for the property is less than or equal to the specified value.
    lte: ?i64 = null,

    /// The value for the property doesn't match (doesn't equal) the specified
    /// value. If you specify multiple values, Macie uses OR logic to join the
    /// values.
    neq: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .eq = "eq",
        .eq_exact_match = "eqExactMatch",
        .gt = "gt",
        .gte = "gte",
        .lt = "lt",
        .lte = "lte",
        .neq = "neq",
    };
};

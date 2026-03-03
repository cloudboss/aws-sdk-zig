/// Performs an aggregation that will return a list of buckets. The list of
/// buckets is a ranked list of the number of occurrences of an aggregation
/// field value.
pub const TermsAggregation = struct {
    /// The number of buckets to return in the response. Default to 10.
    max_buckets: ?i32 = null,

    pub const json_field_names = .{
        .max_buckets = "maxBuckets",
    };
};

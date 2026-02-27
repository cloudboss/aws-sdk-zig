const TermsAggregation = @import("terms_aggregation.zig").TermsAggregation;

/// The type of bucketed aggregation performed.
pub const BucketsAggregationType = struct {
    /// Performs an aggregation that will return a list of buckets. The list of
    /// buckets is a ranked list of the number of occurrences of an aggregation
    /// field value.
    terms_aggregation: ?TermsAggregation,

    pub const json_field_names = .{
        .terms_aggregation = "termsAggregation",
    };
};

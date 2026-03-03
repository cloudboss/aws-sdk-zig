/// Information about the characteristic sets generated in the statistics.
pub const StatisticsSummary = struct {
    /// The total number of characteristic-set instances.
    instance_count: ?i32 = null,

    /// The total number of unique predicates.
    predicate_count: ?i32 = null,

    /// The total number of signatures across all characteristic sets.
    signature_count: ?i32 = null,

    pub const json_field_names = .{
        .instance_count = "instanceCount",
        .predicate_count = "predicateCount",
        .signature_count = "signatureCount",
    };
};

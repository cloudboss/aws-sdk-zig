const Relation = @import("relation.zig").Relation;

/// Represents the total number of matching results and indicates how accurate
/// that count is.
///
/// The `Value` field provides the count, which may be exact or estimated. The
/// `Relation` field indicates whether it's an exact figure or a lower bound.
/// This helps understand the full scope of search results, especially when
/// dealing with large result sets.
pub const TotalHits = struct {
    /// Indicates the relationship between the returned `Value` and the actual total
    /// number of matching results. Possible values are:
    ///
    /// * `EqualTo`: The `Value` is the exact count of matching results.
    /// * `GreaterThanOrEqualTo`: The `Value` is a lower bound of the actual count
    ///   of matching results.
    relation: ?Relation,

    /// The total number of matching results. This value may be exact or an
    /// estimate, depending on the `Relation` field.
    value: ?i64,

    pub const json_field_names = .{
        .relation = "Relation",
        .value = "Value",
    };
};

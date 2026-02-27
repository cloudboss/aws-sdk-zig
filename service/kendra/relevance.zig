const aws = @import("aws");

const Order = @import("order.zig").Order;

/// Provides information for tuning the relevance of a field in a search. When a
/// query
/// includes terms that match the field, the results are given a boost in the
/// response based
/// on these tuning parameters.
pub const Relevance = struct {
    /// Specifies the time period that the boost applies to. For example, to make
    /// the boost
    /// apply to documents with the field value within the last month, you would use
    /// "2628000s".
    /// Once the field value is beyond the specified range, the effect of the boost
    /// drops off.
    /// The higher the importance, the faster the effect drops off. If you don't
    /// specify a
    /// value, the default is 3 months. The value of the field is a numeric string
    /// followed by
    /// the character "s", for example "86400s" for one day, or "604800s" for one
    /// week.
    ///
    /// Only applies to `DATE` fields.
    duration: ?[]const u8,

    /// Indicates that this field determines how "fresh" a document is. For example,
    /// if
    /// document 1 was created on November 5, and document 2 was created on October
    /// 31, document
    /// 1 is "fresher" than document 2. Only applies to `DATE` fields.
    freshness: ?bool,

    /// The relative importance of the field in the search. Larger numbers provide
    /// more of a
    /// boost than smaller numbers.
    importance: ?i32,

    /// Determines how values should be interpreted.
    ///
    /// When the `RankOrder` field is `ASCENDING`, higher numbers are
    /// better. For example, a document with a rating score of 10 is higher ranking
    /// than a
    /// document with a rating score of 1.
    ///
    /// When the `RankOrder` field is `DESCENDING`, lower numbers are
    /// better. For example, in a task tracking application, a priority 1 task is
    /// more important
    /// than a priority 5 task.
    ///
    /// Only applies to `LONG` fields.
    rank_order: ?Order,

    /// A list of values that should be given a different boost when they appear in
    /// the result
    /// list. For example, if you are boosting a field called "department", query
    /// terms that
    /// match the department field are boosted in the result. However, you can add
    /// entries from
    /// the department field to boost documents with those values higher.
    ///
    /// For example, you can add entries to the map with names of departments. If
    /// you add
    /// "HR",5 and "Legal",3 those departments are given special attention when they
    /// appear in
    /// the metadata of a document. When those terms appear they are given the
    /// specified
    /// importance instead of the regular importance for the boost.
    value_importance_map: ?[]const aws.map.MapEntry(i32),

    pub const json_field_names = .{
        .duration = "Duration",
        .freshness = "Freshness",
        .importance = "Importance",
        .rank_order = "RankOrder",
        .value_importance_map = "ValueImportanceMap",
    };
};

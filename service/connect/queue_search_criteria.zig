const SearchableQueueType = @import("searchable_queue_type.zig").SearchableQueueType;
const StringCondition = @import("string_condition.zig").StringCondition;

/// The search criteria to be used to return queues.
///
/// The `name` and `description` fields support "contains" queries with
/// a minimum of 2 characters and a maximum of 25 characters. Any queries with
/// character lengths
/// outside of this range will throw invalid results.
pub const QueueSearchCriteria = struct {
    /// A list of conditions which would be applied together with an AND condition.
    and_conditions: ?[]const QueueSearchCriteria = null,

    /// A list of conditions which would be applied together with an OR condition.
    or_conditions: ?[]const QueueSearchCriteria = null,

    /// The type of queue.
    queue_type_condition: ?SearchableQueueType = null,

    /// A leaf node condition which can be used to specify a string condition.
    ///
    /// The currently supported values for `FieldName` are `name`, `description`,
    /// and
    /// `resourceID`.
    string_condition: ?StringCondition = null,

    pub const json_field_names = .{
        .and_conditions = "AndConditions",
        .or_conditions = "OrConditions",
        .queue_type_condition = "QueueTypeCondition",
        .string_condition = "StringCondition",
    };
};

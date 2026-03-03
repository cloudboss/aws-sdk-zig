const Filter = @import("filter.zig").Filter;

/// The collection of event patterns used to filter events.
///
/// To remove a filter, specify a `FilterCriteria` object with an empty array of
/// `Filter` objects.
///
/// For more information, see [Events and Event
/// Patterns](https://docs.aws.amazon.com/eventbridge/latest/userguide/eventbridge-and-event-patterns.html) in the *Amazon EventBridge User Guide*.
pub const FilterCriteria = struct {
    /// The event patterns.
    filters: ?[]const Filter = null,

    pub const json_field_names = .{
        .filters = "Filters",
    };
};

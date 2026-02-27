const EventCategoryAggregation = @import("event_category_aggregation.zig").EventCategoryAggregation;
const Template = @import("template.zig").Template;

/// An object that contains configuration settings for aggregating events.
pub const AggregationConfiguration = struct {
    /// Specifies the event category for which aggregation should be performed.
    event_category: EventCategoryAggregation,

    /// A list of aggregation templates that can be used to configure event
    /// aggregation.
    templates: []const Template,

    pub const json_field_names = .{
        .event_category = "EventCategory",
        .templates = "Templates",
    };
};

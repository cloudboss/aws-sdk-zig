const DisplayFormat = @import("display_format.zig").DisplayFormat;
const DisplayFormatOptions = @import("display_format_options.zig").DisplayFormatOptions;
const Identifier = @import("identifier.zig").Identifier;
const NamedEntityRef = @import("named_entity_ref.zig").NamedEntityRef;
const TopicSortClause = @import("topic_sort_clause.zig").TopicSortClause;
const TopicTimeGranularity = @import("topic_time_granularity.zig").TopicTimeGranularity;

/// The definition for a `TopicIRGroupBy`.
pub const TopicIRGroupBy = struct {
    /// The display format for the `TopicIRGroupBy`.
    display_format: ?DisplayFormat,

    display_format_options: ?DisplayFormatOptions,

    /// The field name for the `TopicIRGroupBy`.
    field_name: ?Identifier,

    /// The named entity for the `TopicIRGroupBy`.
    named_entity: ?NamedEntityRef,

    /// The sort for the `TopicIRGroupBy`.
    sort: ?TopicSortClause,

    /// The time granularity for the `TopicIRGroupBy`.
    time_granularity: ?TopicTimeGranularity,

    pub const json_field_names = .{
        .display_format = "DisplayFormat",
        .display_format_options = "DisplayFormatOptions",
        .field_name = "FieldName",
        .named_entity = "NamedEntity",
        .sort = "Sort",
        .time_granularity = "TimeGranularity",
    };
};

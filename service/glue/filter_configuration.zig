const aws = @import("aws");

const BetweenConfiguration = @import("between_configuration.zig").BetweenConfiguration;
const FilterMode = @import("filter_mode.zig").FilterMode;
const FilterStringConfiguration = @import("filter_string_configuration.zig").FilterStringConfiguration;

/// Configuration that defines how filter predicates are applied to REST API
/// requests, supporting both query parameter and filter string strategies.
pub const FilterConfiguration = struct {
    /// Configuration for handling BETWEEN range filter operations.
    between_configuration: ?BetweenConfiguration = null,

    /// The global date and time format for filter expressions. Accepts Java
    /// `DateTimeFormatter` patterns (for example, `EEE, d MMM yyyy HH:mm:ss Z`),
    /// `EPOCH_SECONDS` for Unix epoch seconds, or `EPOCH_MILLIS` for Unix epoch
    /// milliseconds. If not specified, values are passed as-is in ISO-8601 format.
    date_time_format: ?[]const u8 = null,

    /// The strategy for applying filters to requests. Use `QUERY_PARAMS` to pass
    /// filters as individual query parameters, or `FILTER_STRING` to construct a
    /// single filter expression string.
    filter_mode: FilterMode,

    /// Configuration for constructing filter expressions when `FilterMode` is set
    /// to `FILTER_STRING`.
    filter_string_configuration: ?FilterStringConfiguration = null,

    /// A map of logical filter operators to their API-specific string
    /// representations. Supported operator keys are: `EQUAL_TO`, `NOT_EQUAL_TO`,
    /// `LESS_THAN`, `GREATER_THAN`, `LESS_THAN_OR_EQUAL_TO`,
    /// `GREATER_THAN_OR_EQUAL_TO`, `CONTAINS`, `BETWEEN`, `AND`, and `OR`.
    operator_mappings: ?[]const aws.map.StringMapEntry = null,

    /// Indicates whether surrounding double quotes should be stripped from filter
    /// values before processing.
    strip_quotes: ?bool = null,

    pub const json_field_names = .{
        .between_configuration = "BetweenConfiguration",
        .date_time_format = "DateTimeFormat",
        .filter_mode = "FilterMode",
        .filter_string_configuration = "FilterStringConfiguration",
        .operator_mappings = "OperatorMappings",
        .strip_quotes = "StripQuotes",
    };
};

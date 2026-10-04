const aws = @import("aws");

const BetweenConfiguration = @import("between_configuration.zig").BetweenConfiguration;

/// Configuration that defines per-field overrides for filter behavior, allowing
/// individual fields to customize how filter operations are applied.
pub const FilterOverrides = struct {
    /// Field-specific configuration for handling BETWEEN range filter operations.
    between_configuration: ?BetweenConfiguration = null,

    /// The date and time format for filter expressions on this field, overriding
    /// the global `DateTimeFormat`. Accepts Java `DateTimeFormatter` patterns (for
    /// example, `EEE, d MMM yyyy HH:mm:ss Z`), `EPOCH_SECONDS` for Unix epoch
    /// seconds, or `EPOCH_MILLIS` for Unix epoch milliseconds.
    date_time_format: ?[]const u8 = null,

    /// An override for the field name to use in filter expressions, if different
    /// from the schema field name.
    field_name: ?[]const u8 = null,

    /// A map of logical filter operators to their field-specific API
    /// representations, overriding the global operator mappings. Supported operator
    /// keys are: `EQUAL_TO`, `NOT_EQUAL_TO`, `LESS_THAN`, `GREATER_THAN`,
    /// `LESS_THAN_OR_EQUAL_TO`, `GREATER_THAN_OR_EQUAL_TO`, `CONTAINS`, `BETWEEN`,
    /// `AND`, and `OR`.
    operator_mappings: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .between_configuration = "BetweenConfiguration",
        .date_time_format = "DateTimeFormat",
        .field_name = "FieldName",
        .operator_mappings = "OperatorMappings",
    };
};

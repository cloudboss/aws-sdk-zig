const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;
const TimeGranularity = @import("time_granularity.zig").TimeGranularity;
const DateTimeFormatConfiguration = @import("date_time_format_configuration.zig").DateTimeFormatConfiguration;

/// The dimension type field with date type columns.
pub const DateDimensionField = struct {
    /// The column that is used in the `DateDimensionField`.
    column: ColumnIdentifier,

    /// The date granularity of the `DateDimensionField`. Choose one of the
    /// following options:
    ///
    /// * `YEAR`
    ///
    /// * `QUARTER`
    ///
    /// * `MONTH`
    ///
    /// * `WEEK`
    ///
    /// * `DAY`
    ///
    /// * `HOUR`
    ///
    /// * `MINUTE`
    ///
    /// * `SECOND`
    ///
    /// * `MILLISECOND`
    date_granularity: ?TimeGranularity = null,

    /// The custom field ID.
    field_id: []const u8,

    /// The format configuration of the field.
    format_configuration: ?DateTimeFormatConfiguration = null,

    /// The custom hierarchy ID.
    hierarchy_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .column = "Column",
        .date_granularity = "DateGranularity",
        .field_id = "FieldId",
        .format_configuration = "FormatConfiguration",
        .hierarchy_id = "HierarchyId",
    };
};

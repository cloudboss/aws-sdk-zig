const TableClass = @import("table_class.zig").TableClass;

/// Contains details of the table class.
pub const TableClassSummary = struct {
    /// The date and time at which the table class was last updated.
    last_update_date_time: ?i64,

    /// The table class of the specified table. Valid values are `STANDARD` and
    /// `STANDARD_INFREQUENT_ACCESS`.
    table_class: ?TableClass,
};

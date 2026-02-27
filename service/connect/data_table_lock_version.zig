/// Contains lock version information for different levels of a data table
/// hierarchy. Used for optimistic locking to
/// prevent concurrent modification conflicts. Each component has its own lock
/// version that changes when that component
/// is modified.
pub const DataTableLockVersion = struct {
    /// The lock version for a specific attribute. When the ValueLockLevel is
    /// ATTRIBUTE, this version changes when any
    /// value for the attribute changes. For other lock levels, it only changes when
    /// the attribute's properties are directly
    /// updated.
    attribute: ?[]const u8,

    /// The lock version for the data table itself. Used for optimistic locking and
    /// table versioning. Changes with each
    /// update to the table's metadata or structure.
    data_table: ?[]const u8,

    /// The lock version for a specific set of primary values (record). This
    /// includes the default record even if the
    /// table does not have any primary attributes. Used for record-level locking.
    primary_values: ?[]const u8,

    /// The lock version for a specific value. Changes each time the individual
    /// value is modified. Used for the
    /// finest-grained locking control.
    value: ?[]const u8,

    pub const json_field_names = .{
        .attribute = "Attribute",
        .data_table = "DataTable",
        .primary_values = "PrimaryValues",
        .value = "Value",
    };
};

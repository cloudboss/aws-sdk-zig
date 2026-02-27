const ParentDataSet = @import("parent_data_set.zig").ParentDataSet;

/// A source table that provides initial data from either a physical table or
/// parent dataset.
pub const SourceTable = struct {
    /// A parent dataset that serves as the data source instead of a physical table.
    data_set: ?ParentDataSet,

    /// The identifier of the physical table that serves as the data source.
    physical_table_id: ?[]const u8,

    pub const json_field_names = .{
        .data_set = "DataSet",
        .physical_table_id = "PhysicalTableId",
    };
};

const TableCellImageScalingConfiguration = @import("table_cell_image_scaling_configuration.zig").TableCellImageScalingConfiguration;

/// The sizing options for the table image configuration.
pub const TableCellImageSizingConfiguration = struct {
    /// The cell scaling configuration of the sizing options for the table image
    /// configuration.
    table_cell_image_scaling_configuration: ?TableCellImageScalingConfiguration,

    pub const json_field_names = .{
        .table_cell_image_scaling_configuration = "TableCellImageScalingConfiguration",
    };
};

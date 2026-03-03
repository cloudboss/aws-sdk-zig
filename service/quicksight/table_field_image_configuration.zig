const TableCellImageSizingConfiguration = @import("table_cell_image_sizing_configuration.zig").TableCellImageSizingConfiguration;

/// The image configuration of a table field URL.
pub const TableFieldImageConfiguration = struct {
    /// The sizing options for the table image configuration.
    sizing_options: ?TableCellImageSizingConfiguration = null,

    pub const json_field_names = .{
        .sizing_options = "SizingOptions",
    };
};

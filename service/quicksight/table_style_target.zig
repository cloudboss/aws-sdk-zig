const StyledCellType = @import("styled_cell_type.zig").StyledCellType;

/// The table style target.
pub const TableStyleTarget = struct {
    /// The cell type of the table style target.
    cell_type: StyledCellType,

    pub const json_field_names = .{
        .cell_type = "CellType",
    };
};

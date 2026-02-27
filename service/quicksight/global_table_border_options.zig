const TableSideBorderOptions = @import("table_side_border_options.zig").TableSideBorderOptions;
const TableBorderOptions = @import("table_border_options.zig").TableBorderOptions;

/// Determines the border options for a table visual.
pub const GlobalTableBorderOptions = struct {
    /// Determines the options for side specific border.
    side_specific_border: ?TableSideBorderOptions,

    /// Determines the options for uniform border.
    uniform_border: ?TableBorderOptions,

    pub const json_field_names = .{
        .side_specific_border = "SideSpecificBorder",
        .uniform_border = "UniformBorder",
    };
};

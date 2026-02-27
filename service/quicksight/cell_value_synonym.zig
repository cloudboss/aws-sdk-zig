/// A structure that represents the cell value synonym.
pub const CellValueSynonym = struct {
    /// The cell value.
    cell_value: ?[]const u8,

    /// Other names or aliases for the cell value.
    synonyms: ?[]const []const u8,

    pub const json_field_names = .{
        .cell_value = "CellValue",
        .synonyms = "Synonyms",
    };
};

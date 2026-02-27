const ImportDataType = @import("import_data_type.zig").ImportDataType;

/// The import data format contains the specifications of the input file that
/// would be passed to the address list import job.
pub const ImportDataFormat = struct {
    /// The type of file that would be passed as an input for the address list
    /// import job.
    import_data_type: ImportDataType,

    pub const json_field_names = .{
        .import_data_type = "ImportDataType",
    };
};

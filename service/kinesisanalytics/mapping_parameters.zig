const CSVMappingParameters = @import("csv_mapping_parameters.zig").CSVMappingParameters;
const JSONMappingParameters = @import("json_mapping_parameters.zig").JSONMappingParameters;

/// When configuring application input
/// at the time of creating or updating an application,
/// provides additional mapping information specific to
/// the record format (such as JSON, CSV, or record fields delimited
/// by some delimiter) on the streaming source.
pub const MappingParameters = struct {
    /// Provides additional mapping information when the record format uses
    /// delimiters
    /// (for example, CSV).
    csv_mapping_parameters: ?CSVMappingParameters = null,

    /// Provides additional mapping information when JSON is the record format on
    /// the streaming source.
    json_mapping_parameters: ?JSONMappingParameters = null,

    pub const json_field_names = .{
        .csv_mapping_parameters = "CSVMappingParameters",
        .json_mapping_parameters = "JSONMappingParameters",
    };
};

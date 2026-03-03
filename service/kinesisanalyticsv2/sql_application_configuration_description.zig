const InputDescription = @import("input_description.zig").InputDescription;
const OutputDescription = @import("output_description.zig").OutputDescription;
const ReferenceDataSourceDescription = @import("reference_data_source_description.zig").ReferenceDataSourceDescription;

/// Describes the inputs, outputs, and reference data sources for a SQL-based
/// Kinesis Data Analytics application.
pub const SqlApplicationConfigurationDescription = struct {
    /// The array of InputDescription objects describing the input streams used
    /// by the application.
    input_descriptions: ?[]const InputDescription = null,

    /// The array of OutputDescription objects describing the destination
    /// streams used by the application.
    output_descriptions: ?[]const OutputDescription = null,

    /// The array of ReferenceDataSourceDescription objects describing the
    /// reference data sources used by the application.
    reference_data_source_descriptions: ?[]const ReferenceDataSourceDescription = null,

    pub const json_field_names = .{
        .input_descriptions = "InputDescriptions",
        .output_descriptions = "OutputDescriptions",
        .reference_data_source_descriptions = "ReferenceDataSourceDescriptions",
    };
};

const Input = @import("input.zig").Input;
const Output = @import("output.zig").Output;
const ReferenceDataSource = @import("reference_data_source.zig").ReferenceDataSource;

/// Describes the inputs, outputs, and reference data sources for a SQL-based
/// Kinesis Data Analytics application.
pub const SqlApplicationConfiguration = struct {
    /// The array of Input objects describing the input streams used by the
    /// application.
    inputs: ?[]const Input,

    /// The array of Output objects describing the destination streams used by
    /// the application.
    outputs: ?[]const Output,

    /// The array of ReferenceDataSource objects describing the reference data
    /// sources used by the application.
    reference_data_sources: ?[]const ReferenceDataSource,

    pub const json_field_names = .{
        .inputs = "Inputs",
        .outputs = "Outputs",
        .reference_data_sources = "ReferenceDataSources",
    };
};

const InputUpdate = @import("input_update.zig").InputUpdate;
const OutputUpdate = @import("output_update.zig").OutputUpdate;
const ReferenceDataSourceUpdate = @import("reference_data_source_update.zig").ReferenceDataSourceUpdate;

/// Describes updates to the input streams, destination streams, and reference
/// data sources
/// for a SQL-based Kinesis Data Analytics application.
pub const SqlApplicationConfigurationUpdate = struct {
    /// The array of InputUpdate objects describing the new input streams used
    /// by the application.
    input_updates: ?[]const InputUpdate = null,

    /// The array of OutputUpdate objects describing the new destination streams
    /// used by the application.
    output_updates: ?[]const OutputUpdate = null,

    /// The array of ReferenceDataSourceUpdate objects describing the new
    /// reference data sources used by the application.
    reference_data_source_updates: ?[]const ReferenceDataSourceUpdate = null,

    pub const json_field_names = .{
        .input_updates = "InputUpdates",
        .output_updates = "OutputUpdates",
        .reference_data_source_updates = "ReferenceDataSourceUpdates",
    };
};

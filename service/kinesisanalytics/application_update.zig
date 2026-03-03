const CloudWatchLoggingOptionUpdate = @import("cloud_watch_logging_option_update.zig").CloudWatchLoggingOptionUpdate;
const InputUpdate = @import("input_update.zig").InputUpdate;
const OutputUpdate = @import("output_update.zig").OutputUpdate;
const ReferenceDataSourceUpdate = @import("reference_data_source_update.zig").ReferenceDataSourceUpdate;

/// Describes updates to apply to an existing Amazon Kinesis Analytics
/// application.
pub const ApplicationUpdate = struct {
    /// Describes application code updates.
    application_code_update: ?[]const u8 = null,

    /// Describes application CloudWatch logging option updates.
    cloud_watch_logging_option_updates: ?[]const CloudWatchLoggingOptionUpdate = null,

    /// Describes application input configuration updates.
    input_updates: ?[]const InputUpdate = null,

    /// Describes application output configuration updates.
    output_updates: ?[]const OutputUpdate = null,

    /// Describes application reference data source updates.
    reference_data_source_updates: ?[]const ReferenceDataSourceUpdate = null,

    pub const json_field_names = .{
        .application_code_update = "ApplicationCodeUpdate",
        .cloud_watch_logging_option_updates = "CloudWatchLoggingOptionUpdates",
        .input_updates = "InputUpdates",
        .output_updates = "OutputUpdates",
        .reference_data_source_updates = "ReferenceDataSourceUpdates",
    };
};

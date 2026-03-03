const DataQuery = @import("data_query.zig").DataQuery;
const DestinationConfigurations = @import("destination_configurations.zig").DestinationConfigurations;
const RefreshCadence = @import("refresh_cadence.zig").RefreshCadence;

/// The details that are available for an export.
pub const Export = struct {
    /// The data query for this specific data export.
    data_query: DataQuery,

    /// The description for this specific data export.
    description: ?[]const u8 = null,

    /// The destination configuration for this specific data export.
    destination_configurations: DestinationConfigurations,

    /// The Amazon Resource Name (ARN) for this export.
    export_arn: ?[]const u8 = null,

    /// The name of this specific data export.
    name: []const u8,

    /// The cadence for Amazon Web Services to update the export in your S3 bucket.
    refresh_cadence: RefreshCadence,

    pub const json_field_names = .{
        .data_query = "DataQuery",
        .description = "Description",
        .destination_configurations = "DestinationConfigurations",
        .export_arn = "ExportArn",
        .name = "Name",
        .refresh_cadence = "RefreshCadence",
    };
};

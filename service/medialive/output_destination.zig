const MediaPackageOutputDestinationSettings = @import("media_package_output_destination_settings.zig").MediaPackageOutputDestinationSettings;
const MultiplexProgramChannelDestinationSettings = @import("multiplex_program_channel_destination_settings.zig").MultiplexProgramChannelDestinationSettings;
const OutputDestinationSettings = @import("output_destination_settings.zig").OutputDestinationSettings;
const SrtOutputDestinationSettings = @import("srt_output_destination_settings.zig").SrtOutputDestinationSettings;

/// Placeholder documentation for OutputDestination
pub const OutputDestination = struct {
    /// User-specified id. This is used in an output group or an output.
    id: ?[]const u8 = null,

    /// Optional assignment of an output to a logical interface on the Node. Only
    /// applies to on premises channels.
    logical_interface_names: ?[]const []const u8 = null,

    /// Destination settings for a MediaPackage output; one destination for both
    /// encoders.
    media_package_settings: ?[]const MediaPackageOutputDestinationSettings = null,

    /// Destination settings for a Multiplex output; one destination for both
    /// encoders.
    multiplex_settings: ?MultiplexProgramChannelDestinationSettings = null,

    /// Destination settings for a standard output; one destination for each
    /// redundant encoder.
    settings: ?[]const OutputDestinationSettings = null,

    /// SRT settings for an SRT output; one destination for each redundant encoder.
    srt_settings: ?[]const SrtOutputDestinationSettings = null,

    pub const json_field_names = .{
        .id = "Id",
        .logical_interface_names = "LogicalInterfaceNames",
        .media_package_settings = "MediaPackageSettings",
        .multiplex_settings = "MultiplexSettings",
        .settings = "Settings",
        .srt_settings = "SrtSettings",
    };
};

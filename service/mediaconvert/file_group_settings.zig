const DestinationSettings = @import("destination_settings.zig").DestinationSettings;

/// Settings related to your File output group. MediaConvert uses this group of
/// settings to generate a single standalone file, rather than a streaming
/// package.
pub const FileGroupSettings = struct {
    /// Use Destination to specify the S3 output location and the output filename
    /// base. Destination accepts format identifiers. If you do not specify the base
    /// filename in the URI, the service will use the filename of the input file. If
    /// your job has multiple inputs, the service uses the filename of the first
    /// input file.
    destination: ?[]const u8,

    /// Settings associated with the destination. Will vary based on the type of
    /// destination
    destination_settings: ?DestinationSettings,

    pub const json_field_names = .{
        .destination = "Destination",
        .destination_settings = "DestinationSettings",
    };
};

const Container = @import("container.zig").Container;
const Metadata = @import("metadata.zig").Metadata;
const TrackMapping = @import("track_mapping.zig").TrackMapping;

/// Probe results for your media file.
pub const ProbeResult = struct {
    /// The container of your media file. This information helps you understand the
    /// overall structure and details of your media, including format, duration, and
    /// track layout.
    container: ?Container = null,

    /// Metadata and other file information.
    metadata: ?Metadata = null,

    /// An array containing track mapping information.
    track_mappings: ?[]const TrackMapping = null,

    pub const json_field_names = .{
        .container = "Container",
        .metadata = "Metadata",
        .track_mappings = "TrackMappings",
    };
};

const StreamSelection = @import("stream_selection.zig").StreamSelection;

/// A Microsoft Smooth Streaming (MSS) manifest configuration.
pub const MssManifest = struct {
    /// An optional string to include in the name of the manifest.
    manifest_name: ?[]const u8,

    stream_selection: ?StreamSelection,

    pub const json_field_names = .{
        .manifest_name = "ManifestName",
        .stream_selection = "StreamSelection",
    };
};

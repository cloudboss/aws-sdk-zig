const StreamSelection = @import("stream_selection.zig").StreamSelection;

/// A Microsoft Smooth Streaming (MSS) manifest configuration.
pub const MssManifest = struct {
    /// An optional string to include in the name of the manifest.
    manifest_name: ?[]const u8 = null,

    stream_selection: ?StreamSelection = null,

    pub const json_field_names = .{
        .manifest_name = "ManifestName",
        .stream_selection = "StreamSelection",
    };
};

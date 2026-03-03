const ConnectedHomeSettings = @import("connected_home_settings.zig").ConnectedHomeSettings;
const FaceSearchSettings = @import("face_search_settings.zig").FaceSearchSettings;

/// Input parameters used in a streaming video analyzed by a Amazon Rekognition
/// stream processor.
/// You can use `FaceSearch` to recognize faces in a streaming video, or you can
/// use `ConnectedHome` to detect labels.
pub const StreamProcessorSettings = struct {
    connected_home: ?ConnectedHomeSettings = null,

    /// Face search settings to use on a streaming video.
    face_search: ?FaceSearchSettings = null,

    pub const json_field_names = .{
        .connected_home = "ConnectedHome",
        .face_search = "FaceSearch",
    };
};

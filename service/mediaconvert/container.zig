const Format = @import("format.zig").Format;
const Track = @import("track.zig").Track;

/// The container of your media file. This information helps you understand the
/// overall structure and details of your media, including format, duration, and
/// track layout.
pub const Container = struct {
    /// The total duration of your media file, in seconds.
    duration: ?f64 = null,

    /// The format of your media file. For example: MP4, QuickTime (MOV), Matroska
    /// (MKV), WebM, MXF or Wave. Note that this will be blank if your media file
    /// has a format that the MediaConvert Probe operation does not recognize.
    format: ?Format = null,

    /// Details about each track (video, audio, or data) in the media file.
    tracks: ?[]const Track = null,

    pub const json_field_names = .{
        .duration = "Duration",
        .format = "Format",
        .tracks = "Tracks",
    };
};

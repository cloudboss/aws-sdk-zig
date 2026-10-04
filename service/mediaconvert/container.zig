const Format = @import("format.zig").Format;
const Track = @import("track.zig").Track;

/// The container of your media file. This information helps you understand the
/// overall structure and details of your media, including format, duration, and
/// track layout.
pub const Container = struct {
    /// The overall bit rate of your media file, in bits per second. This is derived
    /// from the file size and duration as (file size in bytes * 8) / duration in
    /// seconds.
    bit_rate: ?i64 = null,

    /// The total duration of your media file, in seconds.
    duration: ?f64 = null,

    /// The format of your media file. For example: MP4, QuickTime (MOV), Matroska
    /// (MKV), WebM, MXF, Wave, AVI, MPEG-TS, MPEG-PS, MP3, FLAC, ASF (Windows Media
    /// / WMA), OGG, 3GP, 3G2, AAC (raw ADTS), AC-3, or Enhanced AC-3 (E-AC-3). Note
    /// that this will be blank if your media file has a format that the
    /// MediaConvert Probe operation does not recognize.
    format: ?Format = null,

    /// The start timecode of the media file, in HH:MM:SS:FF format (or HH:MM:SS;FF
    /// for drop frame timecode). Note that this field is null when the container
    /// does not include an embedded start timecode.
    start_timecode: ?[]const u8 = null,

    /// Details about each track (video, audio, or data) in the media file.
    tracks: ?[]const Track = null,

    pub const json_field_names = .{
        .bit_rate = "BitRate",
        .duration = "Duration",
        .format = "Format",
        .start_timecode = "StartTimecode",
        .tracks = "Tracks",
    };
};

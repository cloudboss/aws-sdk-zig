const Colorimetry = @import("colorimetry.zig").Colorimetry;
const Range = @import("range.zig").Range;
const ScanMode = @import("scan_mode.zig").ScanMode;
const Tcs = @import("tcs.zig").Tcs;

/// A set of parameters that define the media stream.
pub const Fmtp = struct {
    /// The format of the audio channel.
    channel_order: ?[]const u8,

    /// The format used for the representation of color.
    colorimetry: ?Colorimetry,

    /// The frame rate for the video stream, in frames/second. For example:
    /// 60000/1001.
    exact_framerate: ?[]const u8,

    /// The pixel aspect ratio (PAR) of the video.
    par: ?[]const u8,

    /// The encoding range of the video.
    range: ?Range,

    /// The type of compression that was used to smooth the video’s appearance.
    scan_mode: ?ScanMode,

    /// The transfer characteristic system (TCS) that is used in the video.
    tcs: ?Tcs,

    pub const json_field_names = .{
        .channel_order = "ChannelOrder",
        .colorimetry = "Colorimetry",
        .exact_framerate = "ExactFramerate",
        .par = "Par",
        .range = "Range",
        .scan_mode = "ScanMode",
        .tcs = "Tcs",
    };
};

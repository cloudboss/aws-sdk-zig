const Colorimetry = @import("colorimetry.zig").Colorimetry;
const Range = @import("range.zig").Range;
const ScanMode = @import("scan_mode.zig").ScanMode;
const Tcs = @import("tcs.zig").Tcs;

/// The settings that you want to use to define the media stream.
pub const FmtpRequest = struct {
    /// The format of the audio channel.
    channel_order: ?[]const u8,

    /// The format that is used for the representation of color.
    colorimetry: ?Colorimetry,

    /// The frame rate for the video stream, in frames/second. For example:
    /// 60000/1001. If you specify a whole number, MediaConnect uses a ratio of N/1.
    /// For example, if you specify 60, MediaConnect uses 60/1 as the
    /// `exactFramerate`.
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

const CaptionSourceByteRateLimit = @import("caption_source_byte_rate_limit.zig").CaptionSourceByteRateLimit;
const FileSourceConvert608To708 = @import("file_source_convert_608_to_708.zig").FileSourceConvert608To708;
const CaptionSourceConvertPaintOnToPopOn = @import("caption_source_convert_paint_on_to_pop_on.zig").CaptionSourceConvertPaintOnToPopOn;
const CaptionSourceFramerate = @import("caption_source_framerate.zig").CaptionSourceFramerate;
const FileSourceTimeDeltaUnits = @import("file_source_time_delta_units.zig").FileSourceTimeDeltaUnits;
const CaptionSourceUpconvertSTLToTeletext = @import("caption_source_upconvert_stl_to_teletext.zig").CaptionSourceUpconvertSTLToTeletext;

/// If your input captions are SCC, SMI, SRT, STL, TTML, WebVTT, or IMSC 1.1 in
/// an xml file, specify the URI of the input caption source file. If your
/// caption source is IMSC in an IMF package, use TrackSourceSettings instead of
/// FileSoureSettings.
pub const FileSourceSettings = struct {
    /// Choose whether to limit the byte rate at which your SCC input captions are
    /// inserted into your output. To not limit the caption rate: We recommend that
    /// you keep the default value, Disabled. MediaConvert inserts captions in your
    /// output according to the byte rates listed in the EIA-608 specification,
    /// typically 2 or 3 caption bytes per frame depending on your output frame
    /// rate. To limit your output caption rate: Choose Enabled. Choose this option
    /// if your downstream systems require a maximum of 2 caption bytes per frame.
    /// Note that this setting has no effect when your output frame rate is 30 or
    /// 60.
    byte_rate_limit: ?CaptionSourceByteRateLimit = null,

    /// Specify whether this set of input captions appears in your outputs in both
    /// 608 and 708 format. If you choose Upconvert, MediaConvert includes the
    /// captions data in two ways: it passes the 608 data through using the 608
    /// compatibility bytes fields of the 708 wrapper, and it also translates the
    /// 608 data into 708.
    convert_608_to_708: ?FileSourceConvert608To708 = null,

    /// Choose the presentation style of your input SCC captions. To use the same
    /// presentation style as your input: Keep the default value, Disabled. To
    /// convert paint-on captions to pop-on: Choose Enabled. We also recommend that
    /// you choose Enabled if you notice additional repeated lines in your output
    /// captions.
    convert_paint_to_pop: ?CaptionSourceConvertPaintOnToPopOn = null,

    /// Ignore this setting unless your input captions format is SCC. To have the
    /// service compensate for differing frame rates between your input captions and
    /// input video, specify the frame rate of the captions file. Specify this value
    /// as a fraction. For example, you might specify 24 / 1 for 24 fps, 25 / 1 for
    /// 25 fps, 24000 / 1001 for 23.976 fps, or 30000 / 1001 for 29.97 fps.
    framerate: ?CaptionSourceFramerate = null,

    /// External caption file used for loading captions. Accepted file extensions
    /// are 'scc', 'ttml', 'dfxp', 'stl', 'srt', 'xml', 'smi', 'webvtt', and 'vtt'.
    source_file: ?[]const u8 = null,

    /// Optional. Use this setting when you need to adjust the sync between your
    /// sidecar captions and your video. For more information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/time-delta-use-cases.html. Enter a positive or negative number to modify the times in the captions file. For example, type 15 to add 15 seconds to all the times in the captions file. Type -5 to subtract 5 seconds from the times in the captions file. You can optionally specify your time delta in milliseconds instead of seconds. When you do so, set the related setting, Time delta units to Milliseconds. Note that, when you specify a time delta for timecode-based caption sources, such as SCC and STL, and your time delta isn't a multiple of the input frame rate, MediaConvert snaps the captions to the nearest frame. For example, when your input video frame rate is 25 fps and you specify 1010ms for time delta, MediaConvert delays your captions by 1000 ms.
    time_delta: ?i32 = null,

    /// When you use the setting Time delta to adjust the sync between your sidecar
    /// captions and your video, use this setting to specify the units for the delta
    /// that you specify. When you don't specify a value for Time delta units,
    /// MediaConvert uses seconds by default.
    time_delta_units: ?FileSourceTimeDeltaUnits = null,

    /// Specify whether this set of input captions appears in your outputs in both
    /// STL and Teletext format. If you choose Upconvert, MediaConvert includes the
    /// captions data in two ways: it passes the STL data through using the Teletext
    /// compatibility bytes fields of the Teletext wrapper, and it also translates
    /// the STL data into Teletext.
    upconvert_stl_to_teletext: ?CaptionSourceUpconvertSTLToTeletext = null,

    pub const json_field_names = .{
        .byte_rate_limit = "ByteRateLimit",
        .convert_608_to_708 = "Convert608To708",
        .convert_paint_to_pop = "ConvertPaintToPop",
        .framerate = "Framerate",
        .source_file = "SourceFile",
        .time_delta = "TimeDelta",
        .time_delta_units = "TimeDeltaUnits",
        .upconvert_stl_to_teletext = "UpconvertSTLToTeletext",
    };
};

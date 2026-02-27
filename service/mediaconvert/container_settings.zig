const CmfcSettings = @import("cmfc_settings.zig").CmfcSettings;
const ContainerType = @import("container_type.zig").ContainerType;
const F4vSettings = @import("f4_v_settings.zig").F4vSettings;
const M2tsSettings = @import("m2_ts_settings.zig").M2tsSettings;
const M3u8Settings = @import("m3_u_8_settings.zig").M3u8Settings;
const MovSettings = @import("mov_settings.zig").MovSettings;
const Mp4Settings = @import("mp_4_settings.zig").Mp4Settings;
const MpdSettings = @import("mpd_settings.zig").MpdSettings;
const MxfSettings = @import("mxf_settings.zig").MxfSettings;

/// Container specific settings.
pub const ContainerSettings = struct {
    /// These settings relate to the fragmented MP4 container for the segments in
    /// your CMAF outputs.
    cmfc_settings: ?CmfcSettings,

    /// Container for this output. Some containers require a container settings
    /// object. If not specified, the default object will be created.
    container: ?ContainerType,

    /// Settings for F4v container
    f4_v_settings: ?F4vSettings,

    /// MPEG-2 TS container settings. These apply to outputs in a File output group
    /// when the output's container is MPEG-2 Transport Stream (M2TS). In these
    /// assets, data is organized by the program map table (PMT). Each transport
    /// stream program contains subsets of data, including audio, video, and
    /// metadata. Each of these subsets of data has a numerical label called a
    /// packet identifier (PID). Each transport stream program corresponds to one
    /// MediaConvert output. The PMT lists the types of data in a program along with
    /// their PID. Downstream systems and players use the program map table to look
    /// up the PID for each type of data it accesses and then uses the PIDs to
    /// locate specific data within the asset.
    m2_ts_settings: ?M2tsSettings,

    /// These settings relate to the MPEG-2 transport stream (MPEG2-TS) container
    /// for the MPEG2-TS segments in your HLS outputs.
    m3_u_8_settings: ?M3u8Settings,

    /// These settings relate to your QuickTime MOV output container.
    mov_settings: ?MovSettings,

    /// These settings relate to your MP4 output container. You can create audio
    /// only outputs with this container. For more information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/supported-codecs-containers-audio-only.html#output-codecs-and-containers-supported-for-audio-only.
    mp_4_settings: ?Mp4Settings,

    /// These settings relate to the fragmented MP4 container for the segments in
    /// your DASH outputs.
    mpd_settings: ?MpdSettings,

    /// These settings relate to your MXF output container.
    mxf_settings: ?MxfSettings,

    pub const json_field_names = .{
        .cmfc_settings = "CmfcSettings",
        .container = "Container",
        .f4_v_settings = "F4vSettings",
        .m2_ts_settings = "M2tsSettings",
        .m3_u_8_settings = "M3u8Settings",
        .mov_settings = "MovSettings",
        .mp_4_settings = "Mp4Settings",
        .mpd_settings = "MpdSettings",
        .mxf_settings = "MxfSettings",
    };
};

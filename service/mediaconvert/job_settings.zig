const AvailBlanking = @import("avail_blanking.zig").AvailBlanking;
const ColorConversion3DLUTSetting = @import("color_conversion_3_dlut_setting.zig").ColorConversion3DLUTSetting;
const EsamSettings = @import("esam_settings.zig").EsamSettings;
const ExtendedDataServices = @import("extended_data_services.zig").ExtendedDataServices;
const Input = @import("input.zig").Input;
const KantarWatermarkSettings = @import("kantar_watermark_settings.zig").KantarWatermarkSettings;
const MotionImageInserter = @import("motion_image_inserter.zig").MotionImageInserter;
const NielsenConfiguration = @import("nielsen_configuration.zig").NielsenConfiguration;
const NielsenNonLinearWatermarkSettings = @import("nielsen_non_linear_watermark_settings.zig").NielsenNonLinearWatermarkSettings;
const OutputGroup = @import("output_group.zig").OutputGroup;
const TimecodeConfig = @import("timecode_config.zig").TimecodeConfig;
const TimedMetadataInsertion = @import("timed_metadata_insertion.zig").TimedMetadataInsertion;

/// JobSettings contains all the transcode settings for a job.
pub const JobSettings = struct {
    /// When specified, this offset (in milliseconds) is added to the input Ad Avail
    /// PTS time.
    ad_avail_offset: ?i32,

    /// Settings for ad avail blanking. Video can be blanked or overlaid with an
    /// image, and audio muted during SCTE-35 triggered ad avails.
    avail_blanking: ?AvailBlanking,

    /// Use 3D LUTs to specify custom color mapping behavior when you convert from
    /// one color space into another. You can include up to 8 different 3D LUTs. For
    /// more information, see:
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/3d-luts.html
    color_conversion_3_dlut_settings: ?[]const ColorConversion3DLUTSetting,

    /// Settings for Event Signaling And Messaging (ESAM). If you don't do ad
    /// insertion, you can ignore these settings.
    esam: ?EsamSettings,

    /// If your source content has EIA-608 Line 21 Data Services, enable this
    /// feature to specify what MediaConvert does with the Extended Data Services
    /// (XDS) packets. You can choose to pass through XDS packets, or remove them
    /// from the output. For more information about XDS, see EIA-608 Line Data
    /// Services, section 9.5.1.5 05h Content Advisory.
    extended_data_services: ?ExtendedDataServices,

    /// Specify the input that MediaConvert references for your default output
    /// settings. MediaConvert uses this input's Resolution, Frame rate, and Pixel
    /// aspect ratio for all outputs that you don't manually specify different
    /// output settings for. Enabling this setting will disable "Follow source" for
    /// all other inputs. If MediaConvert cannot follow your source, for example if
    /// you specify an audio-only input, MediaConvert uses the first followable
    /// input instead. In your JSON job specification, enter an integer from 1 to
    /// 150 corresponding to the order of your inputs.
    follow_source: ?i32,

    /// Use Inputs to define source file used in the transcode job. There can be
    /// multiple inputs add in a job. These inputs will be concantenated together to
    /// create the output.
    inputs: ?[]const Input,

    /// Use these settings only when you use Kantar watermarking. Specify the values
    /// that MediaConvert uses to generate and place Kantar watermarks in your
    /// output audio. These settings apply to every output in your job. In addition
    /// to specifying these values, you also need to store your Kantar credentials
    /// in AWS Secrets Manager. For more information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/kantar-watermarking.html.
    kantar_watermark: ?KantarWatermarkSettings,

    /// Overlay motion graphics on top of your video. The motion graphics that you
    /// specify here appear on all outputs in all output groups. For more
    /// information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/motion-graphic-overlay.html.
    motion_image_inserter: ?MotionImageInserter,

    /// Settings for your Nielsen configuration. If you don't do Nielsen measurement
    /// and analytics, ignore these settings. When you enable Nielsen configuration,
    /// MediaConvert enables PCM to ID3 tagging for all outputs in the job.
    nielsen_configuration: ?NielsenConfiguration,

    /// Ignore these settings unless you are using Nielsen non-linear watermarking.
    /// Specify the values that MediaConvert uses to generate and place Nielsen
    /// watermarks in your output audio. In addition to specifying these values, you
    /// also need to set up your cloud TIC server. These settings apply to every
    /// output in your job. The MediaConvert implementation is currently with the
    /// following Nielsen versions: Nielsen Watermark SDK Version 6.0.13 Nielsen NLM
    /// Watermark Engine Version 1.3.3 Nielsen Watermark Authenticator [SID_TIC]
    /// Version [7.0.0]
    nielsen_non_linear_watermark: ?NielsenNonLinearWatermarkSettings,

    /// Contains one group of settings for each set of outputs that share a common
    /// package type. All unpackaged files (MPEG-4, MPEG-2 TS, Quicktime, MXF, and
    /// no container) are grouped in a single output group as well. Required in is a
    /// group of settings that apply to the whole group. This required object
    /// depends on the value you set for Type. Type, settings object pairs are as
    /// follows. * FILE_GROUP_SETTINGS, FileGroupSettings * HLS_GROUP_SETTINGS,
    /// HlsGroupSettings * DASH_ISO_GROUP_SETTINGS, DashIsoGroupSettings *
    /// MS_SMOOTH_GROUP_SETTINGS, MsSmoothGroupSettings * CMAF_GROUP_SETTINGS,
    /// CmafGroupSettings
    output_groups: ?[]const OutputGroup,

    /// These settings control how the service handles timecodes throughout the job.
    /// These settings don't affect input clipping.
    timecode_config: ?TimecodeConfig,

    /// Insert user-defined custom ID3 metadata at timecodes that you specify. In
    /// each output that you want to include this metadata, you must set ID3
    /// metadata to Passthrough.
    timed_metadata_insertion: ?TimedMetadataInsertion,

    pub const json_field_names = .{
        .ad_avail_offset = "AdAvailOffset",
        .avail_blanking = "AvailBlanking",
        .color_conversion_3_dlut_settings = "ColorConversion3DLUTSettings",
        .esam = "Esam",
        .extended_data_services = "ExtendedDataServices",
        .follow_source = "FollowSource",
        .inputs = "Inputs",
        .kantar_watermark = "KantarWatermark",
        .motion_image_inserter = "MotionImageInserter",
        .nielsen_configuration = "NielsenConfiguration",
        .nielsen_non_linear_watermark = "NielsenNonLinearWatermark",
        .output_groups = "OutputGroups",
        .timecode_config = "TimecodeConfig",
        .timed_metadata_insertion = "TimedMetadataInsertion",
    };
};

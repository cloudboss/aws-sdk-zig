const aws = @import("aws");

const AdvancedInputFilter = @import("advanced_input_filter.zig").AdvancedInputFilter;
const AdvancedInputFilterSettings = @import("advanced_input_filter_settings.zig").AdvancedInputFilterSettings;
const AudioSelectorGroup = @import("audio_selector_group.zig").AudioSelectorGroup;
const AudioSelector = @import("audio_selector.zig").AudioSelector;
const CaptionSelector = @import("caption_selector.zig").CaptionSelector;
const Rectangle = @import("rectangle.zig").Rectangle;
const InputDeblockFilter = @import("input_deblock_filter.zig").InputDeblockFilter;
const InputDenoiseFilter = @import("input_denoise_filter.zig").InputDenoiseFilter;
const DynamicAudioSelector = @import("dynamic_audio_selector.zig").DynamicAudioSelector;
const InputFilterEnable = @import("input_filter_enable.zig").InputFilterEnable;
const ImageInserter = @import("image_inserter.zig").ImageInserter;
const InputClipping = @import("input_clipping.zig").InputClipping;
const InputScanType = @import("input_scan_type.zig").InputScanType;
const MultiViewSettings = @import("multi_view_settings.zig").MultiViewSettings;
const InputPsiControl = @import("input_psi_control.zig").InputPsiControl;
const InputTimecodeSource = @import("input_timecode_source.zig").InputTimecodeSource;
const VideoOverlay = @import("video_overlay.zig").VideoOverlay;
const VideoSelector = @import("video_selector.zig").VideoSelector;

/// Specified video input in a template.
pub const InputTemplate = struct {
    /// Use to remove noise, blocking, blurriness, or ringing from your input as a
    /// pre-filter step before encoding. The Advanced input filter removes more
    /// types of compression artifacts and is an improvement when compared to basic
    /// Deblock and Denoise filters. To remove video compression artifacts from your
    /// input and improve the video quality: Choose Enabled. Additionally, this
    /// filter can help increase the video quality of your output relative to its
    /// bitrate, since noisy inputs are more complex and require more bits to
    /// encode. To help restore loss of detail after applying the filter, you can
    /// optionally add texture or sharpening as an additional step. Jobs that use
    /// this feature incur pro-tier pricing. To not apply advanced input filtering:
    /// Choose Disabled. Note that you can still apply basic filtering with Deblock
    /// and Denoise.
    advanced_input_filter: ?AdvancedInputFilter = null,

    /// Optional settings for Advanced input filter when you set Advanced input
    /// filter to Enabled.
    advanced_input_filter_settings: ?AdvancedInputFilterSettings = null,

    /// Use audio selector groups to combine multiple sidecar audio inputs so that
    /// you can assign them to a single output audio tab. Note that, if you're
    /// working with embedded audio, it's simpler to assign multiple input tracks
    /// into a single audio selector rather than use an audio selector group.
    audio_selector_groups: ?[]const aws.map.MapEntry(AudioSelectorGroup) = null,

    /// Use Audio selectors to specify a track or set of tracks from the input that
    /// you will use in your outputs. You can use multiple Audio selectors per
    /// input.
    audio_selectors: ?[]const aws.map.MapEntry(AudioSelector) = null,

    /// Use captions selectors to specify the captions data from your input that you
    /// use in your outputs. You can use up to 100 captions selectors per input.
    caption_selectors: ?[]const aws.map.MapEntry(CaptionSelector) = null,

    /// Use Cropping selection to specify the video area that the service will
    /// include in the output video frame. If you specify a value here, it will
    /// override any value that you specify in the output setting Cropping
    /// selection.
    crop: ?Rectangle = null,

    /// Enable Deblock to produce smoother motion in the output. Default is
    /// disabled. Only manually controllable for MPEG2 and uncompressed video
    /// inputs.
    deblock_filter: ?InputDeblockFilter = null,

    /// Enable Denoise to filter noise from the input. Default is disabled. Only
    /// applicable to MPEG2, H.264, H.265, and uncompressed video inputs.
    denoise_filter: ?InputDenoiseFilter = null,

    /// Use this setting only when your video source has Dolby Vision studio
    /// mastering metadata that is carried in a separate XML file. Specify the
    /// Amazon S3 location for the metadata XML file. MediaConvert uses this file to
    /// provide global and frame-level metadata for Dolby Vision preprocessing. When
    /// you specify a file here and your input also has interleaved global and frame
    /// level metadata, MediaConvert ignores the interleaved metadata and uses only
    /// the the metadata from this external XML file. Note that your IAM service
    /// role must grant MediaConvert read permissions to this file. For more
    /// information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/iam-role.html.
    dolby_vision_metadata_xml: ?[]const u8 = null,

    /// Use Dynamic audio selectors when you do not know the track layout of your
    /// source when you submit your job, but want to select multiple audio tracks.
    /// When you include an audio track in your output and specify this Dynamic
    /// audio selector as the Audio source, MediaConvert creates an output audio
    /// track for each dynamically selected track. Note that when you include a
    /// Dynamic audio selector for two or more inputs, each input must have the same
    /// number of audio tracks and audio channels.
    dynamic_audio_selectors: ?[]const aws.map.MapEntry(DynamicAudioSelector) = null,

    /// Specify whether to apply input filtering to improve the video quality of
    /// your input. To apply filtering depending on your input type and quality:
    /// Choose Auto. To apply no filtering: Choose Disable. To apply filtering
    /// regardless of your input type and quality: Choose Force. When you do, you
    /// must also specify a value for Filter strength.
    filter_enable: ?InputFilterEnable = null,

    /// Specify the strength of the input filter. To apply an automatic amount of
    /// filtering based the compression artifacts measured in your input: We
    /// recommend that you leave Filter strength blank and set Filter enable to
    /// Auto. To manually apply filtering: Enter a value from 1 to 5, where 1 is the
    /// least amount of filtering and 5 is the most. The value that you enter
    /// applies to the strength of the Deblock or Denoise filters, or to the
    /// strength of the Advanced input filter.
    filter_strength: ?i32 = null,

    /// Enable the image inserter feature to include a graphic overlay on your
    /// video. Enable or disable this feature for each input individually. This
    /// setting is disabled by default.
    image_inserter: ?ImageInserter = null,

    /// Contains sets of start and end times that together specify a portion of the
    /// input to be used in the outputs. If you provide only a start time, the clip
    /// will be the entire input from that point to the end. If you provide only an
    /// end time, it will be the entire input up to that point. When you specify
    /// more than one input clip, the transcoding service creates the job outputs by
    /// stringing the clips together in the order you specify them.
    input_clippings: ?[]const InputClipping = null,

    /// When you have a progressive segmented frame (PsF) input, use this setting to
    /// flag the input as PsF. MediaConvert doesn't automatically detect PsF.
    /// Therefore, flagging your input as PsF results in better preservation of
    /// video quality when you do deinterlacing and frame rate conversion. If you
    /// don't specify, the default value is Auto. Auto is the correct setting for
    /// all inputs that are not PsF. Don't set this value to PsF when your input is
    /// interlaced. Doing so creates horizontal interlacing artifacts.
    input_scan_type: ?InputScanType = null,

    /// Specify the enhancement layer input video file path for Multi View outputs.
    /// The base layer input is treated as the left eye and this Multi View input is
    /// treated as the right eye. Only one Multi View input is currently supported.
    /// MediaConvert encodes both views into a single MV-HEVC output codec. When you
    /// add MultiViewSettings to your job, you can only produce Multi View outputs.
    /// Adding any other codec output to the same job is not supported.
    multi_view_settings: ?[]const MultiViewSettings = null,

    /// Use Selection placement to define the video area in your output frame. The
    /// area outside of the rectangle that you specify here is black. If you specify
    /// a value here, it will override any value that you specify in the output
    /// setting Selection placement. If you specify a value here, this will override
    /// any AFD values in your input, even if you set Respond to AFD to Respond. If
    /// you specify a value here, this will ignore anything that you specify for the
    /// setting Scaling Behavior.
    position: ?Rectangle = null,

    /// Use Program to select a specific program from within a multi-program
    /// transport stream. Note that Quad 4K is not currently supported. Default is
    /// the first program within the transport stream. If the program you specify
    /// doesn't exist, the transcoding service will use this default.
    program_number: ?i32 = null,

    /// Set PSI control for transport stream inputs to specify which data the demux
    /// process to scans.
    /// * Ignore PSI - Scan all PIDs for audio and video.
    /// * Use PSI - Scan only PSI data.
    psi_control: ?InputPsiControl = null,

    /// Use this Timecode source setting, located under the input settings, to
    /// specify how the service counts input video frames. This input frame count
    /// affects only the behavior of features that apply to a single input at a
    /// time, such as input clipping and synchronizing some captions formats. Choose
    /// Embedded to use the timecodes in your input video. Choose Start at zero to
    /// start the first frame at zero. Choose Specified start to start the first
    /// frame at the timecode that you specify in the setting Start timecode. If you
    /// don't specify a value for Timecode source, the service will use Embedded by
    /// default. For more information about timecodes, see
    /// https://docs.aws.amazon.com/console/mediaconvert/timecode.
    timecode_source: ?InputTimecodeSource = null,

    /// Specify the timecode that you want the service to use for this input's
    /// initial frame. To use this setting, you must set the Timecode source
    /// setting, located under the input settings, to Specified start. For more
    /// information about timecodes, see
    /// https://docs.aws.amazon.com/console/mediaconvert/timecode.
    timecode_start: ?[]const u8 = null,

    /// Contains an array of video overlays.
    video_overlays: ?[]const VideoOverlay = null,

    /// Input video selectors contain the video settings for the input. Each of your
    /// inputs can have up to one video selector.
    video_selector: ?VideoSelector = null,

    pub const json_field_names = .{
        .advanced_input_filter = "AdvancedInputFilter",
        .advanced_input_filter_settings = "AdvancedInputFilterSettings",
        .audio_selector_groups = "AudioSelectorGroups",
        .audio_selectors = "AudioSelectors",
        .caption_selectors = "CaptionSelectors",
        .crop = "Crop",
        .deblock_filter = "DeblockFilter",
        .denoise_filter = "DenoiseFilter",
        .dolby_vision_metadata_xml = "DolbyVisionMetadataXml",
        .dynamic_audio_selectors = "DynamicAudioSelectors",
        .filter_enable = "FilterEnable",
        .filter_strength = "FilterStrength",
        .image_inserter = "ImageInserter",
        .input_clippings = "InputClippings",
        .input_scan_type = "InputScanType",
        .multi_view_settings = "MultiViewSettings",
        .position = "Position",
        .program_number = "ProgramNumber",
        .psi_control = "PsiControl",
        .timecode_source = "TimecodeSource",
        .timecode_start = "TimecodeStart",
        .video_overlays = "VideoOverlays",
        .video_selector = "VideoSelector",
    };
};

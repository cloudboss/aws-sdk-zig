const HlsAudioOnlyContainer = @import("hls_audio_only_container.zig").HlsAudioOnlyContainer;
const HlsAudioTrackType = @import("hls_audio_track_type.zig").HlsAudioTrackType;
const HlsDescriptiveVideoServiceFlag = @import("hls_descriptive_video_service_flag.zig").HlsDescriptiveVideoServiceFlag;
const HlsIFrameOnlyManifest = @import("hls_i_frame_only_manifest.zig").HlsIFrameOnlyManifest;

/// Settings for HLS output groups
pub const HlsSettings = struct {
    /// Specifies the group to which the audio rendition belongs.
    audio_group_id: ?[]const u8 = null,

    /// Use this setting only in audio-only outputs. Choose MPEG-2 Transport Stream
    /// (M2TS) to create a file in an MPEG2-TS container. Keep the default value
    /// Automatic to create an audio-only file in a raw container. Regardless of the
    /// value that you specify here, if this output has video, the service will
    /// place the output into an MPEG2-TS container.
    audio_only_container: ?HlsAudioOnlyContainer = null,

    /// List all the audio groups that are used with the video output stream. Input
    /// all the audio GROUP-IDs that are associated to the video, separate by ','.
    audio_rendition_sets: ?[]const u8 = null,

    /// Four types of audio-only tracks are supported: Audio-Only Variant Stream The
    /// client can play back this audio-only stream instead of video in
    /// low-bandwidth scenarios. Represented as an EXT-X-STREAM-INF in the HLS
    /// manifest. Alternate Audio, Auto Select, Default Alternate rendition that the
    /// client should try to play back by default. Represented as an EXT-X-MEDIA in
    /// the HLS manifest with DEFAULT=YES, AUTOSELECT=YES Alternate Audio, Auto
    /// Select, Not Default Alternate rendition that the client may try to play back
    /// by default. Represented as an EXT-X-MEDIA in the HLS manifest with
    /// DEFAULT=NO, AUTOSELECT=YES Alternate Audio, not Auto Select Alternate
    /// rendition that the client will not try to play back by default. Represented
    /// as an EXT-X-MEDIA in the HLS manifest with DEFAULT=NO, AUTOSELECT=NO
    audio_track_type: ?HlsAudioTrackType = null,

    /// Specify whether to flag this audio track as descriptive video service (DVS)
    /// in your HLS parent manifest. When you choose Flag, MediaConvert includes the
    /// parameter CHARACTERISTICS="public.accessibility.describes-video" in the
    /// EXT-X-MEDIA entry for this track. When you keep the default choice, Don't
    /// flag, MediaConvert leaves this parameter out. The DVS flag can help with
    /// accessibility on Apple devices. For more information, see the Apple
    /// documentation.
    descriptive_video_service_flag: ?HlsDescriptiveVideoServiceFlag = null,

    /// Generate a variant manifest that lists only the I-frames for this rendition.
    /// You might use this manifest as part of a workflow that creates preview
    /// functions for your video. MediaConvert adds both the I-frame only variant
    /// manifest and the regular variant manifest to the multivariant manifest. To
    /// have MediaConvert write a variant manifest that references I-frames from
    /// your output content using EXT-X-BYTERANGE tags: Choose Include. To have
    /// MediaConvert output I-frames as single frame TS files and a corresponding
    /// variant manifest that references them: Choose Include as TS. When you don't
    /// need the I-frame only variant manifest: Keep the default value, Exclude.
    i_frame_only_manifest: ?HlsIFrameOnlyManifest = null,

    /// Use this setting to add an identifying string to the filename of each
    /// segment. The service adds this string between the name modifier and segment
    /// index number. You can use format identifiers in the string. For more
    /// information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/using-variables-in-your-job-settings.html
    segment_modifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .audio_group_id = "AudioGroupId",
        .audio_only_container = "AudioOnlyContainer",
        .audio_rendition_sets = "AudioRenditionSets",
        .audio_track_type = "AudioTrackType",
        .descriptive_video_service_flag = "DescriptiveVideoServiceFlag",
        .i_frame_only_manifest = "IFrameOnlyManifest",
        .segment_modifier = "SegmentModifier",
    };
};

const InputLocation = @import("input_location.zig").InputLocation;
const AudioOnlyHlsTrackType = @import("audio_only_hls_track_type.zig").AudioOnlyHlsTrackType;
const AudioOnlyHlsSegmentType = @import("audio_only_hls_segment_type.zig").AudioOnlyHlsSegmentType;

/// Audio Only Hls Settings
pub const AudioOnlyHlsSettings = struct {
    /// Specifies the group to which the audio Rendition belongs.
    audio_group_id: ?[]const u8 = null,

    /// Optional. Specifies the .jpg or .png image to use as the cover art for an
    /// audio-only output. We recommend a low bit-size file because the image
    /// increases the output audio bandwidth.
    ///
    /// The image is attached to the audio as an ID3 tag, frame type APIC, picture
    /// type 0x10, as per the "ID3 tag version 2.4.0 - Native Frames" standard.
    audio_only_image: ?InputLocation = null,

    /// Four types of audio-only tracks are supported:
    ///
    /// Audio-Only Variant Stream
    /// The client can play back this audio-only stream instead of video in
    /// low-bandwidth scenarios. Represented as an EXT-X-STREAM-INF in the HLS
    /// manifest.
    ///
    /// Alternate Audio, Auto Select, Default
    /// Alternate rendition that the client should try to play back by default.
    /// Represented as an EXT-X-MEDIA in the HLS manifest with DEFAULT=YES,
    /// AUTOSELECT=YES
    ///
    /// Alternate Audio, Auto Select, Not Default
    /// Alternate rendition that the client may try to play back by default.
    /// Represented as an EXT-X-MEDIA in the HLS manifest with DEFAULT=NO,
    /// AUTOSELECT=YES
    ///
    /// Alternate Audio, not Auto Select
    /// Alternate rendition that the client will not try to play back by default.
    /// Represented as an EXT-X-MEDIA in the HLS manifest with DEFAULT=NO,
    /// AUTOSELECT=NO
    audio_track_type: ?AudioOnlyHlsTrackType = null,

    /// Specifies the segment type.
    segment_type: ?AudioOnlyHlsSegmentType = null,

    pub const json_field_names = .{
        .audio_group_id = "AudioGroupId",
        .audio_only_image = "AudioOnlyImage",
        .audio_track_type = "AudioTrackType",
        .segment_type = "SegmentType",
    };
};

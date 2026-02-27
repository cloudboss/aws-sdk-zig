const CmfcAudioDuration = @import("cmfc_audio_duration.zig").CmfcAudioDuration;
const CmfcAudioTrackType = @import("cmfc_audio_track_type.zig").CmfcAudioTrackType;
const CmfcC2paManifest = @import("cmfc_c2_pa_manifest.zig").CmfcC2paManifest;
const CmfcDescriptiveVideoServiceFlag = @import("cmfc_descriptive_video_service_flag.zig").CmfcDescriptiveVideoServiceFlag;
const CmfcIFrameOnlyManifest = @import("cmfc_i_frame_only_manifest.zig").CmfcIFrameOnlyManifest;
const CmfcKlvMetadata = @import("cmfc_klv_metadata.zig").CmfcKlvMetadata;
const CmfcManifestMetadataSignaling = @import("cmfc_manifest_metadata_signaling.zig").CmfcManifestMetadataSignaling;
const CmfcScte35Esam = @import("cmfc_scte_35_esam.zig").CmfcScte35Esam;
const CmfcScte35Source = @import("cmfc_scte_35_source.zig").CmfcScte35Source;
const CmfcTimedMetadata = @import("cmfc_timed_metadata.zig").CmfcTimedMetadata;
const CmfcTimedMetadataBoxVersion = @import("cmfc_timed_metadata_box_version.zig").CmfcTimedMetadataBoxVersion;

/// These settings relate to the fragmented MP4 container for the segments in
/// your CMAF outputs.
pub const CmfcSettings = struct {
    /// Specify this setting only when your output will be consumed by a downstream
    /// repackaging workflow that is sensitive to very small duration differences
    /// between video and audio. For this situation, choose Match video duration. In
    /// all other cases, keep the default value, Default codec duration. When you
    /// choose Match video duration, MediaConvert pads the output audio streams with
    /// silence or trims them to ensure that the total duration of each audio stream
    /// is at least as long as the total duration of the video stream. After padding
    /// or trimming, the audio stream duration is no more than one frame longer than
    /// the video stream. MediaConvert applies audio padding or trimming only to the
    /// end of the last segment of the output. For unsegmented outputs, MediaConvert
    /// adds padding only to the end of the file. When you keep the default value,
    /// any minor discrepancies between audio and video duration will depend on your
    /// output audio codec.
    audio_duration: ?CmfcAudioDuration,

    /// Specify the audio rendition group for this audio rendition. Specify up to
    /// one value for each audio output in your output group. This value appears in
    /// your HLS parent manifest in the EXT-X-MEDIA tag of TYPE=AUDIO, as the value
    /// for the GROUP-ID attribute. For example, if you specify "audio_aac_1" for
    /// Audio group ID, it appears in your manifest like this:
    /// #EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="audio_aac_1". Related setting: To
    /// associate the rendition group that this audio track belongs to with a video
    /// rendition, include the same value that you provide here for that video
    /// output's setting Audio rendition sets.
    audio_group_id: ?[]const u8,

    /// List the audio rendition groups that you want included with this video
    /// rendition. Use a comma-separated list. For example, say you want to include
    /// the audio rendition groups that have the audio group IDs "audio_aac_1" and
    /// "audio_dolby". Then you would specify this value: "audio_aac_1,audio_dolby".
    /// Related setting: The rendition groups that you include in your
    /// comma-separated list should all match values that you specify in the setting
    /// Audio group ID for audio renditions in the same output group as this video
    /// rendition. Default behavior: If you don't specify anything here and for
    /// Audio group ID, MediaConvert puts each audio variant in its own audio
    /// rendition group and associates it with every video variant. Each value in
    /// your list appears in your HLS parent manifest in the EXT-X-STREAM-INF tag as
    /// the value for the AUDIO attribute. To continue the previous example, say
    /// that the file name for the child manifest for your video rendition is
    /// "amazing_video_1.m3u8". Then, in your parent manifest, each value will
    /// appear on separate lines, like this:
    /// #EXT-X-STREAM-INF:AUDIO="audio_aac_1"... amazing_video_1.m3u8
    /// #EXT-X-STREAM-INF:AUDIO="audio_dolby"... amazing_video_1.m3u8
    audio_rendition_sets: ?[]const u8,

    /// Use this setting to control the values that MediaConvert puts in your HLS
    /// parent playlist to control how the client player selects which audio track
    /// to play. Choose Audio-only variant stream (AUDIO_ONLY_VARIANT_STREAM) for
    /// any variant that you want to prohibit the client from playing with video.
    /// This causes MediaConvert to represent the variant as an EXT-X-STREAM-INF in
    /// the HLS manifest. The other options for this setting determine the values
    /// that MediaConvert writes for the DEFAULT and AUTOSELECT attributes of the
    /// EXT-X-MEDIA entry for the audio variant. For more information about these
    /// attributes, see the Apple documentation article
    /// https://developer.apple.com/documentation/http_live_streaming/example_playlists_for_http_live_streaming/adding_alternate_media_to_a_playlist. Choose Alternate audio, auto select, default to set DEFAULT=YES and AUTOSELECT=YES. Choose this value for only one variant in your output group. Choose Alternate audio, auto select, not default to set DEFAULT=NO and AUTOSELECT=YES. Choose Alternate Audio, Not Auto Select to set DEFAULT=NO and AUTOSELECT=NO. When you don't specify a value for this setting, MediaConvert defaults to Alternate audio, auto select, default. When there is more than one variant in your output group, you must explicitly choose a value for this setting.
    audio_track_type: ?CmfcAudioTrackType,

    /// When enabled, a C2PA compliant manifest will be generated, signed and
    /// embeded in the output. For more information on C2PA, see
    /// https://c2pa.org/specifications/specifications/2.1/index.html
    c2_pa_manifest: ?CmfcC2paManifest,

    /// Specify the name or ARN of the AWS Secrets Manager secret that contains your
    /// C2PA public certificate chain in PEM format. Provide a valid secret name or
    /// ARN. Note that your MediaConvert service role must allow access to this
    /// secret. The public certificate chain is added to the COSE header (x5chain)
    /// for signature validation. Include the signer's certificate and all
    /// intermediate certificates. Do not include the root certificate. For details
    /// on COSE, see:
    /// https://opensource.contentauthenticity.org/docs/manifest/signing-manifests
    certificate_secret: ?[]const u8,

    /// Specify whether to flag this audio track as descriptive video service (DVS)
    /// in your HLS parent manifest. When you choose Flag, MediaConvert includes the
    /// parameter CHARACTERISTICS="public.accessibility.describes-video" in the
    /// EXT-X-MEDIA entry for this track. When you keep the default choice, Don't
    /// flag, MediaConvert leaves this parameter out. The DVS flag can help with
    /// accessibility on Apple devices. For more information, see the Apple
    /// documentation.
    descriptive_video_service_flag: ?CmfcDescriptiveVideoServiceFlag,

    /// Choose Include to have MediaConvert generate an HLS child manifest that
    /// lists only the I-frames for this rendition, in addition to your regular
    /// manifest for this rendition. You might use this manifest as part of a
    /// workflow that creates preview functions for your video. MediaConvert adds
    /// both the I-frame only child manifest and the regular child manifest to the
    /// parent manifest. When you don't need the I-frame only child manifest, keep
    /// the default value Exclude.
    i_frame_only_manifest: ?CmfcIFrameOnlyManifest,

    /// To include key-length-value metadata in this output: Set KLV metadata
    /// insertion to Passthrough. MediaConvert reads KLV metadata present in your
    /// input and writes each instance to a separate event message box in the
    /// output, according to MISB ST1910.1. To exclude this KLV metadata: Set KLV
    /// metadata insertion to None or leave blank.
    klv_metadata: ?CmfcKlvMetadata,

    /// To add an InbandEventStream element in your output MPD manifest for each
    /// type of event message, set Manifest metadata signaling to Enabled. For ID3
    /// event messages, the InbandEventStream element schemeIdUri will be same value
    /// that you specify for ID3 metadata scheme ID URI. For SCTE35 event messages,
    /// the InbandEventStream element schemeIdUri will be
    /// "urn:scte:scte35:2013:bin". To leave these elements out of your output MPD
    /// manifest, set Manifest metadata signaling to Disabled. To enable Manifest
    /// metadata signaling, you must also set SCTE-35 source to Passthrough, ESAM
    /// SCTE-35 to insert, or ID3 metadata to Passthrough.
    manifest_metadata_signaling: ?CmfcManifestMetadataSignaling,

    /// Use this setting only when you specify SCTE-35 markers from ESAM. Choose
    /// INSERT to put SCTE-35 markers in this output at the insertion points that
    /// you specify in an ESAM XML document. Provide the document in the setting SCC
    /// XML.
    scte_35_esam: ?CmfcScte35Esam,

    /// Ignore this setting unless you have SCTE-35 markers in your input video
    /// file. Choose Passthrough if you want SCTE-35 markers that appear in your
    /// input to also appear in this output. Choose None if you don't want those
    /// SCTE-35 markers in this output.
    scte_35_source: ?CmfcScte35Source,

    /// Specify the ID or ARN of the AWS KMS key used to sign the C2PA manifest in
    /// your MP4 output. Provide a valid KMS key ARN. Note that your MediaConvert
    /// service role must allow access to this key.
    signing_kms_key: ?[]const u8,

    /// To include ID3 metadata in this output: Set ID3 metadata to Passthrough.
    /// Specify this ID3 metadata in Custom ID3 metadata inserter. MediaConvert
    /// writes each instance of ID3 metadata in a separate Event Message (eMSG) box.
    /// To exclude this ID3 metadata: Set ID3 metadata to None or leave blank.
    timed_metadata: ?CmfcTimedMetadata,

    /// Specify the event message box (eMSG) version for ID3 timed metadata in your
    /// output.
    /// For more information, see ISO/IEC 23009-1:2022 section 5.10.3.3.3 Syntax.
    /// Leave blank to use the default value Version 0.
    /// When you specify Version 1, you must also set ID3 metadata to Passthrough.
    timed_metadata_box_version: ?CmfcTimedMetadataBoxVersion,

    /// Specify the event message box (eMSG) scheme ID URI for ID3 timed metadata in
    /// your output. For more information, see ISO/IEC 23009-1:2022 section
    /// 5.10.3.3.4 Semantics. Leave blank to use the default value:
    /// https://aomedia.org/emsg/ID3 When you specify a value for ID3 metadata
    /// scheme ID URI, you must also set ID3 metadata to Passthrough.
    timed_metadata_scheme_id_uri: ?[]const u8,

    /// Specify the event message box (eMSG) value for ID3 timed metadata in your
    /// output. For more information, see ISO/IEC 23009-1:2022 section 5.10.3.3.4
    /// Semantics. When you specify a value for ID3 Metadata Value, you must also
    /// set ID3 metadata to Passthrough.
    timed_metadata_value: ?[]const u8,

    pub const json_field_names = .{
        .audio_duration = "AudioDuration",
        .audio_group_id = "AudioGroupId",
        .audio_rendition_sets = "AudioRenditionSets",
        .audio_track_type = "AudioTrackType",
        .c2_pa_manifest = "C2paManifest",
        .certificate_secret = "CertificateSecret",
        .descriptive_video_service_flag = "DescriptiveVideoServiceFlag",
        .i_frame_only_manifest = "IFrameOnlyManifest",
        .klv_metadata = "KlvMetadata",
        .manifest_metadata_signaling = "ManifestMetadataSignaling",
        .scte_35_esam = "Scte35Esam",
        .scte_35_source = "Scte35Source",
        .signing_kms_key = "SigningKmsKey",
        .timed_metadata = "TimedMetadata",
        .timed_metadata_box_version = "TimedMetadataBoxVersion",
        .timed_metadata_scheme_id_uri = "TimedMetadataSchemeIdUri",
        .timed_metadata_value = "TimedMetadataValue",
    };
};

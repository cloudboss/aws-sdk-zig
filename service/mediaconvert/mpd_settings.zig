const MpdAccessibilityCaptionHints = @import("mpd_accessibility_caption_hints.zig").MpdAccessibilityCaptionHints;
const MpdAudioDuration = @import("mpd_audio_duration.zig").MpdAudioDuration;
const MpdC2paManifest = @import("mpd_c2_pa_manifest.zig").MpdC2paManifest;
const MpdCaptionContainerType = @import("mpd_caption_container_type.zig").MpdCaptionContainerType;
const MpdKlvMetadata = @import("mpd_klv_metadata.zig").MpdKlvMetadata;
const MpdManifestMetadataSignaling = @import("mpd_manifest_metadata_signaling.zig").MpdManifestMetadataSignaling;
const MpdScte35Esam = @import("mpd_scte_35_esam.zig").MpdScte35Esam;
const MpdScte35Source = @import("mpd_scte_35_source.zig").MpdScte35Source;
const MpdTimedMetadata = @import("mpd_timed_metadata.zig").MpdTimedMetadata;
const MpdTimedMetadataBoxVersion = @import("mpd_timed_metadata_box_version.zig").MpdTimedMetadataBoxVersion;

/// These settings relate to the fragmented MP4 container for the segments in
/// your DASH outputs.
pub const MpdSettings = struct {
    /// Optional. Choose Include to have MediaConvert mark up your DASH manifest
    /// with elements for embedded 608 captions. This markup isn't generally
    /// required, but some video players require it to discover and play embedded
    /// 608 captions. Keep the default value, Exclude, to leave these elements out.
    /// When you enable this setting, this is the markup that MediaConvert includes
    /// in your manifest:
    accessibility_caption_hints: ?MpdAccessibilityCaptionHints = null,

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
    audio_duration: ?MpdAudioDuration = null,

    /// When enabled, a C2PA compliant manifest will be generated, signed and
    /// embeded in the output. For more information on C2PA, see
    /// https://c2pa.org/specifications/specifications/2.1/index.html
    c2_pa_manifest: ?MpdC2paManifest = null,

    /// Use this setting only in DASH output groups that include sidecar TTML, IMSC
    /// or WEBVTT captions. You specify sidecar captions in a separate output from
    /// your audio and video. Choose Raw for captions in a single XML file in a raw
    /// container. Choose Fragmented MPEG-4 for captions in XML format contained
    /// within fragmented MP4 files. This set of fragmented MP4 files is separate
    /// from your video and audio fragmented MP4 files.
    caption_container_type: ?MpdCaptionContainerType = null,

    /// Specify the name or ARN of the AWS Secrets Manager secret that contains your
    /// C2PA public certificate chain in PEM format. Provide a valid secret name or
    /// ARN. Note that your MediaConvert service role must allow access to this
    /// secret. The public certificate chain is added to the COSE header (x5chain)
    /// for signature validation. Include the signer's certificate and all
    /// intermediate certificates. Do not include the root certificate. For details
    /// on COSE, see:
    /// https://opensource.contentauthenticity.org/docs/manifest/signing-manifests
    certificate_secret: ?[]const u8 = null,

    /// To include key-length-value metadata in this output: Set KLV metadata
    /// insertion to Passthrough. MediaConvert reads KLV metadata present in your
    /// input and writes each instance to a separate event message box in the
    /// output, according to MISB ST1910.1. To exclude this KLV metadata: Set KLV
    /// metadata insertion to None or leave blank.
    klv_metadata: ?MpdKlvMetadata = null,

    /// To add an InbandEventStream element in your output MPD manifest for each
    /// type of event message, set Manifest metadata signaling to Enabled. For ID3
    /// event messages, the InbandEventStream element schemeIdUri will be same value
    /// that you specify for ID3 metadata scheme ID URI. For SCTE35 event messages,
    /// the InbandEventStream element schemeIdUri will be
    /// "urn:scte:scte35:2013:bin". To leave these elements out of your output MPD
    /// manifest, set Manifest metadata signaling to Disabled. To enable Manifest
    /// metadata signaling, you must also set SCTE-35 source to Passthrough, ESAM
    /// SCTE-35 to insert, or ID3 metadata to Passthrough.
    manifest_metadata_signaling: ?MpdManifestMetadataSignaling = null,

    /// Use this setting only when you specify SCTE-35 markers from ESAM. Choose
    /// INSERT to put SCTE-35 markers in this output at the insertion points that
    /// you specify in an ESAM XML document. Provide the document in the setting SCC
    /// XML.
    scte_35_esam: ?MpdScte35Esam = null,

    /// Ignore this setting unless you have SCTE-35 markers in your input video
    /// file. Choose Passthrough if you want SCTE-35 markers that appear in your
    /// input to also appear in this output. Choose None if you don't want those
    /// SCTE-35 markers in this output.
    scte_35_source: ?MpdScte35Source = null,

    /// Specify the ID or ARN of the AWS KMS key used to sign the C2PA manifest in
    /// your MP4 output. Provide a valid KMS key ARN. Note that your MediaConvert
    /// service role must allow access to this key.
    signing_kms_key: ?[]const u8 = null,

    /// To include ID3 metadata in this output: Set ID3 metadata to Passthrough.
    /// Specify this ID3 metadata in Custom ID3 metadata inserter. MediaConvert
    /// writes each instance of ID3 metadata in a separate Event Message (eMSG) box.
    /// To exclude this ID3 metadata: Set ID3 metadata to None or leave blank.
    timed_metadata: ?MpdTimedMetadata = null,

    /// Specify the event message box (eMSG) version for ID3 timed metadata in your
    /// output.
    /// For more information, see ISO/IEC 23009-1:2022 section 5.10.3.3.3 Syntax.
    /// Leave blank to use the default value Version 0.
    /// When you specify Version 1, you must also set ID3 metadata to Passthrough.
    timed_metadata_box_version: ?MpdTimedMetadataBoxVersion = null,

    /// Specify the event message box (eMSG) scheme ID URI for ID3 timed metadata in
    /// your output. For more information, see ISO/IEC 23009-1:2022 section
    /// 5.10.3.3.4 Semantics. Leave blank to use the default value:
    /// https://aomedia.org/emsg/ID3 When you specify a value for ID3 metadata
    /// scheme ID URI, you must also set ID3 metadata to Passthrough.
    timed_metadata_scheme_id_uri: ?[]const u8 = null,

    /// Specify the event message box (eMSG) value for ID3 timed metadata in your
    /// output. For more information, see ISO/IEC 23009-1:2022 section 5.10.3.3.4
    /// Semantics. When you specify a value for ID3 Metadata Value, you must also
    /// set ID3 metadata to Passthrough.
    timed_metadata_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .accessibility_caption_hints = "AccessibilityCaptionHints",
        .audio_duration = "AudioDuration",
        .c2_pa_manifest = "C2paManifest",
        .caption_container_type = "CaptionContainerType",
        .certificate_secret = "CertificateSecret",
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

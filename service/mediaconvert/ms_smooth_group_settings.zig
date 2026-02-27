const MsSmoothAdditionalManifest = @import("ms_smooth_additional_manifest.zig").MsSmoothAdditionalManifest;
const MsSmoothAudioDeduplication = @import("ms_smooth_audio_deduplication.zig").MsSmoothAudioDeduplication;
const DestinationSettings = @import("destination_settings.zig").DestinationSettings;
const MsSmoothEncryptionSettings = @import("ms_smooth_encryption_settings.zig").MsSmoothEncryptionSettings;
const MsSmoothFragmentLengthControl = @import("ms_smooth_fragment_length_control.zig").MsSmoothFragmentLengthControl;
const MsSmoothManifestEncoding = @import("ms_smooth_manifest_encoding.zig").MsSmoothManifestEncoding;

/// Settings related to your Microsoft Smooth Streaming output package. For more
/// information, see
/// https://docs.aws.amazon.com/mediaconvert/latest/ug/outputs-file-ABR.html.
pub const MsSmoothGroupSettings = struct {
    /// By default, the service creates one .ism Microsoft Smooth Streaming manifest
    /// for each Microsoft Smooth Streaming output group in your job. This default
    /// manifest references every output in the output group. To create additional
    /// manifests that reference a subset of the outputs in the output group,
    /// specify a list of them here.
    additional_manifests: ?[]const MsSmoothAdditionalManifest,

    /// COMBINE_DUPLICATE_STREAMS combines identical audio encoding settings across
    /// a Microsoft Smooth output group into a single audio stream.
    audio_deduplication: ?MsSmoothAudioDeduplication,

    /// Use Destination to specify the S3 output location and the output filename
    /// base. Destination accepts format identifiers. If you do not specify the base
    /// filename in the URI, the service will use the filename of the input file. If
    /// your job has multiple inputs, the service uses the filename of the first
    /// input file.
    destination: ?[]const u8,

    /// Settings associated with the destination. Will vary based on the type of
    /// destination
    destination_settings: ?DestinationSettings,

    /// If you are using DRM, set DRM System to specify the value SpekeKeyProvider.
    encryption: ?MsSmoothEncryptionSettings,

    /// Specify how you want MediaConvert to determine the fragment length. Choose
    /// Exact to have the encoder use the exact length that you specify with the
    /// setting Fragment length. This might result in extra I-frames. Choose
    /// Multiple of GOP to have the encoder round up the segment lengths to match
    /// the next GOP boundary.
    fragment_length: ?i32,

    /// Specify how you want MediaConvert to determine the fragment length. Choose
    /// Exact to have the encoder use the exact length that you specify with the
    /// setting Fragment length. This might result in extra I-frames. Choose
    /// Multiple of GOP to have the encoder round up the segment lengths to match
    /// the next GOP boundary.
    fragment_length_control: ?MsSmoothFragmentLengthControl,

    /// Use Manifest encoding to specify the encoding format for the server and
    /// client manifest. Valid options are utf8 and utf16.
    manifest_encoding: ?MsSmoothManifestEncoding,

    pub const json_field_names = .{
        .additional_manifests = "AdditionalManifests",
        .audio_deduplication = "AudioDeduplication",
        .destination = "Destination",
        .destination_settings = "DestinationSettings",
        .encryption = "Encryption",
        .fragment_length = "FragmentLength",
        .fragment_length_control = "FragmentLengthControl",
        .manifest_encoding = "ManifestEncoding",
    };
};

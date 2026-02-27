const CmfcAudioDuration = @import("cmfc_audio_duration.zig").CmfcAudioDuration;
const Mp4C2paManifest = @import("mp_4_c2_pa_manifest.zig").Mp4C2paManifest;
const Mp4CslgAtom = @import("mp_4_cslg_atom.zig").Mp4CslgAtom;
const Mp4FreeSpaceBox = @import("mp_4_free_space_box.zig").Mp4FreeSpaceBox;
const Mp4MoovPlacement = @import("mp_4_moov_placement.zig").Mp4MoovPlacement;

/// These settings relate to your MP4 output container. You can create audio
/// only outputs with this container. For more information, see
/// https://docs.aws.amazon.com/mediaconvert/latest/ug/supported-codecs-containers-audio-only.html#output-codecs-and-containers-supported-for-audio-only.
pub const Mp4Settings = struct {
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

    /// When enabled, a C2PA compliant manifest will be generated, signed and
    /// embeded in the output. For more information on C2PA, see
    /// https://c2pa.org/specifications/specifications/2.1/index.html
    c2_pa_manifest: ?Mp4C2paManifest,

    /// Specify the name or ARN of the AWS Secrets Manager secret that contains your
    /// C2PA public certificate chain in PEM format. Provide a valid secret name or
    /// ARN. Note that your MediaConvert service role must allow access to this
    /// secret. The public certificate chain is added to the COSE header (x5chain)
    /// for signature validation. Include the signer's certificate and all
    /// intermediate certificates. Do not include the root certificate. For details
    /// on COSE, see:
    /// https://opensource.contentauthenticity.org/docs/manifest/signing-manifests
    certificate_secret: ?[]const u8,

    /// When enabled, file composition times will start at zero, composition times
    /// in the 'ctts' (composition time to sample) box for B-frames will be
    /// negative, and a 'cslg' (composition shift least greatest) box will be
    /// included per 14496-1 amendment 1. This improves compatibility with Apple
    /// players and tools.
    cslg_atom: ?Mp4CslgAtom,

    /// Ignore this setting unless compliance to the CTTS box version specification
    /// matters in your workflow. Specify a value of 1 to set your CTTS box version
    /// to 1 and make your output compliant with the specification. When you specify
    /// a value of 1, you must also set CSLG atom to the value INCLUDE. Keep the
    /// default value 0 to set your CTTS box version to 0. This can provide backward
    /// compatibility for some players and packagers.
    ctts_version: ?i32,

    /// Inserts a free-space box immediately after the moov box.
    free_space_box: ?Mp4FreeSpaceBox,

    /// To place the MOOV atom at the beginning of your output, which is useful for
    /// progressive downloading: Leave blank or choose Progressive download. To
    /// place the MOOV at the end of your output: Choose Normal.
    moov_placement: ?Mp4MoovPlacement,

    /// Overrides the "Major Brand" field in the output file. Usually not necessary
    /// to specify.
    mp_4_major_brand: ?[]const u8,

    /// Specify the ID or ARN of the AWS KMS key used to sign the C2PA manifest in
    /// your MP4 output. Provide a valid KMS key ARN. Note that your MediaConvert
    /// service role must allow access to this key.
    signing_kms_key: ?[]const u8,

    pub const json_field_names = .{
        .audio_duration = "AudioDuration",
        .c2_pa_manifest = "C2paManifest",
        .certificate_secret = "CertificateSecret",
        .cslg_atom = "CslgAtom",
        .ctts_version = "CttsVersion",
        .free_space_box = "FreeSpaceBox",
        .moov_placement = "MoovPlacement",
        .mp_4_major_brand = "Mp4MajorBrand",
        .signing_kms_key = "SigningKmsKey",
    };
};

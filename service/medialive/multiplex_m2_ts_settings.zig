const M2tsAbsentInputAudioBehavior = @import("m2_ts_absent_input_audio_behavior.zig").M2tsAbsentInputAudioBehavior;
const M2tsArib = @import("m2_ts_arib.zig").M2tsArib;
const M2tsAudioBufferModel = @import("m2_ts_audio_buffer_model.zig").M2tsAudioBufferModel;
const M2tsAudioStreamType = @import("m2_ts_audio_stream_type.zig").M2tsAudioStreamType;
const M2tsCcDescriptor = @import("m2_ts_cc_descriptor.zig").M2tsCcDescriptor;
const M2tsEbifControl = @import("m2_ts_ebif_control.zig").M2tsEbifControl;
const M2tsEsRateInPes = @import("m2_ts_es_rate_in_pes.zig").M2tsEsRateInPes;
const M2tsKlv = @import("m2_ts_klv.zig").M2tsKlv;
const M2tsNielsenId3Behavior = @import("m2_ts_nielsen_id_3_behavior.zig").M2tsNielsenId3Behavior;
const M2tsPcrControl = @import("m2_ts_pcr_control.zig").M2tsPcrControl;
const M2tsScte35Control = @import("m2_ts_scte_35_control.zig").M2tsScte35Control;

/// Multiplex M2ts Settings
pub const MultiplexM2tsSettings = struct {
    /// When set to drop, output audio streams will be removed from the program if
    /// the selected input audio stream is removed from the input. This allows the
    /// output audio configuration to dynamically change based on input
    /// configuration. If this is set to encodeSilence, all output audio streams
    /// will output encoded silence when not connected to an active input stream.
    absent_input_audio_behavior: ?M2tsAbsentInputAudioBehavior,

    /// When set to enabled, uses ARIB-compliant field muxing and removes video
    /// descriptor.
    arib: ?M2tsArib,

    /// When set to dvb, uses DVB buffer model for Dolby Digital audio. When set to
    /// atsc, the ATSC model is used.
    audio_buffer_model: ?M2tsAudioBufferModel,

    /// The number of audio frames to insert for each PES packet.
    audio_frames_per_pes: ?i32,

    /// When set to atsc, uses stream type = 0x81 for AC3 and stream type = 0x87 for
    /// EAC3. When set to dvb, uses stream type = 0x06.
    audio_stream_type: ?M2tsAudioStreamType,

    /// When set to enabled, generates captionServiceDescriptor in PMT.
    cc_descriptor: ?M2tsCcDescriptor,

    /// If set to passthrough, passes any EBIF data from the input source to this
    /// output.
    ebif: ?M2tsEbifControl,

    /// Include or exclude the ES Rate field in the PES header.
    es_rate_in_pes: ?M2tsEsRateInPes,

    /// If set to passthrough, passes any KLV data from the input source to this
    /// output.
    klv: ?M2tsKlv,

    /// If set to passthrough, Nielsen inaudible tones for media tracking will be
    /// detected in the input audio and an equivalent ID3 tag will be inserted in
    /// the output.
    nielsen_id_3_behavior: ?M2tsNielsenId3Behavior,

    /// When set to pcrEveryPesPacket, a Program Clock Reference value is inserted
    /// for every Packetized Elementary Stream (PES) header. This parameter is
    /// effective only when the PCR PID is the same as the video or audio elementary
    /// stream.
    pcr_control: ?M2tsPcrControl,

    /// Maximum time in milliseconds between Program Clock Reference (PCRs) inserted
    /// into the transport stream.
    pcr_period: ?i32,

    /// Optionally pass SCTE-35 signals from the input source to this output.
    scte_35_control: ?M2tsScte35Control,

    /// Defines the amount SCTE-35 preroll will be increased (in milliseconds) on
    /// the output. Preroll is the amount of time between the presence of a SCTE-35
    /// indication in a transport stream and the PTS of the video frame it
    /// references. Zero means don't add pullup (it doesn't mean set the preroll to
    /// zero). Negative pullup is not supported, which means that you can't make the
    /// preroll shorter. Be aware that latency in the output will increase by the
    /// pullup amount.
    scte_35_preroll_pullup_milliseconds: ?f64,

    pub const json_field_names = .{
        .absent_input_audio_behavior = "AbsentInputAudioBehavior",
        .arib = "Arib",
        .audio_buffer_model = "AudioBufferModel",
        .audio_frames_per_pes = "AudioFramesPerPes",
        .audio_stream_type = "AudioStreamType",
        .cc_descriptor = "CcDescriptor",
        .ebif = "Ebif",
        .es_rate_in_pes = "EsRateInPes",
        .klv = "Klv",
        .nielsen_id_3_behavior = "NielsenId3Behavior",
        .pcr_control = "PcrControl",
        .pcr_period = "PcrPeriod",
        .scte_35_control = "Scte35Control",
        .scte_35_preroll_pullup_milliseconds = "Scte35PrerollPullupMilliseconds",
    };
};

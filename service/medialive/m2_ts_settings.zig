const M2tsAbsentInputAudioBehavior = @import("m2_ts_absent_input_audio_behavior.zig").M2tsAbsentInputAudioBehavior;
const M2tsArib = @import("m2_ts_arib.zig").M2tsArib;
const M2tsAribCaptionsPidControl = @import("m2_ts_arib_captions_pid_control.zig").M2tsAribCaptionsPidControl;
const M2tsAudioBufferModel = @import("m2_ts_audio_buffer_model.zig").M2tsAudioBufferModel;
const M2tsAudioStreamType = @import("m2_ts_audio_stream_type.zig").M2tsAudioStreamType;
const M2tsBufferModel = @import("m2_ts_buffer_model.zig").M2tsBufferModel;
const M2tsCcDescriptor = @import("m2_ts_cc_descriptor.zig").M2tsCcDescriptor;
const DvbNitSettings = @import("dvb_nit_settings.zig").DvbNitSettings;
const DvbSdtSettings = @import("dvb_sdt_settings.zig").DvbSdtSettings;
const DvbTdtSettings = @import("dvb_tdt_settings.zig").DvbTdtSettings;
const M2tsEbifControl = @import("m2_ts_ebif_control.zig").M2tsEbifControl;
const M2tsAudioInterval = @import("m2_ts_audio_interval.zig").M2tsAudioInterval;
const M2tsEbpPlacement = @import("m2_ts_ebp_placement.zig").M2tsEbpPlacement;
const M2tsEsRateInPes = @import("m2_ts_es_rate_in_pes.zig").M2tsEsRateInPes;
const M2tsKlv = @import("m2_ts_klv.zig").M2tsKlv;
const M2tsNielsenId3Behavior = @import("m2_ts_nielsen_id_3_behavior.zig").M2tsNielsenId3Behavior;
const M2tsPcrControl = @import("m2_ts_pcr_control.zig").M2tsPcrControl;
const M2tsRateMode = @import("m2_ts_rate_mode.zig").M2tsRateMode;
const M2tsScte35Control = @import("m2_ts_scte_35_control.zig").M2tsScte35Control;
const M2tsSegmentationMarkers = @import("m2_ts_segmentation_markers.zig").M2tsSegmentationMarkers;
const M2tsSegmentationStyle = @import("m2_ts_segmentation_style.zig").M2tsSegmentationStyle;
const M2tsTimedMetadataBehavior = @import("m2_ts_timed_metadata_behavior.zig").M2tsTimedMetadataBehavior;

/// M2ts Settings
pub const M2tsSettings = struct {
    /// When set to drop, output audio streams will be removed from the program if
    /// the selected input audio stream is removed from the input. This allows the
    /// output audio configuration to dynamically change based on input
    /// configuration. If this is set to encodeSilence, all output audio streams
    /// will output encoded silence when not connected to an active input stream.
    absent_input_audio_behavior: ?M2tsAbsentInputAudioBehavior,

    /// When set to enabled, uses ARIB-compliant field muxing and removes video
    /// descriptor.
    arib: ?M2tsArib,

    /// Packet Identifier (PID) for ARIB Captions in the transport stream. Can be
    /// entered as a decimal or hexadecimal value. Valid values are 32 (or
    /// 0x20)..8182 (or 0x1ff6).
    arib_captions_pid: ?[]const u8,

    /// If set to auto, pid number used for ARIB Captions will be auto-selected from
    /// unused pids. If set to useConfigured, ARIB Captions will be on the
    /// configured pid number.
    arib_captions_pid_control: ?M2tsAribCaptionsPidControl,

    /// When set to dvb, uses DVB buffer model for Dolby Digital audio. When set to
    /// atsc, the ATSC model is used.
    audio_buffer_model: ?M2tsAudioBufferModel,

    /// The number of audio frames to insert for each PES packet.
    audio_frames_per_pes: ?i32,

    /// Packet Identifier (PID) of the elementary audio stream(s) in the transport
    /// stream. Multiple values are accepted, and can be entered in ranges and/or by
    /// comma separation. Can be entered as decimal or hexadecimal values. Each PID
    /// specified must be in the range of 32 (or 0x20)..8182 (or 0x1ff6).
    audio_pids: ?[]const u8,

    /// When set to atsc, uses stream type = 0x81 for AC3 and stream type = 0x87 for
    /// EAC3. When set to dvb, uses stream type = 0x06.
    audio_stream_type: ?M2tsAudioStreamType,

    /// The output bitrate of the transport stream in bits per second. Setting to 0
    /// lets the muxer automatically determine the appropriate bitrate.
    bitrate: ?i32,

    /// Controls the timing accuracy for output network traffic. Leave as MULTIPLEX
    /// to ensure accurate network packet timing. Or set to NONE, which might result
    /// in lower latency but will result in more variability in output network
    /// packet timing. This variability might cause interruptions, jitter, or bursty
    /// behavior in your playback or receiving devices.
    buffer_model: ?M2tsBufferModel,

    /// When set to enabled, generates captionServiceDescriptor in PMT.
    cc_descriptor: ?M2tsCcDescriptor,

    /// Inserts DVB Network Information Table (NIT) at the specified table
    /// repetition interval.
    dvb_nit_settings: ?DvbNitSettings,

    /// Inserts DVB Service Description Table (SDT) at the specified table
    /// repetition interval.
    dvb_sdt_settings: ?DvbSdtSettings,

    /// Packet Identifier (PID) for input source DVB Subtitle data to this output.
    /// Multiple values are accepted, and can be entered in ranges and/or by comma
    /// separation. Can be entered as decimal or hexadecimal values. Each PID
    /// specified must be in the range of 32 (or 0x20)..8182 (or 0x1ff6).
    dvb_sub_pids: ?[]const u8,

    /// Inserts DVB Time and Date Table (TDT) at the specified table repetition
    /// interval.
    dvb_tdt_settings: ?DvbTdtSettings,

    /// Packet Identifier (PID) for input source DVB Teletext data to this output.
    /// Can be entered as a decimal or hexadecimal value. Valid values are 32 (or
    /// 0x20)..8182 (or 0x1ff6).
    dvb_teletext_pid: ?[]const u8,

    /// If set to passthrough, passes any EBIF data from the input source to this
    /// output.
    ebif: ?M2tsEbifControl,

    /// When videoAndFixedIntervals is selected, audio EBP markers will be added to
    /// partitions 3 and 4. The interval between these additional markers will be
    /// fixed, and will be slightly shorter than the video EBP marker interval. Only
    /// available when EBP Cablelabs segmentation markers are selected. Partitions 1
    /// and 2 will always follow the video interval.
    ebp_audio_interval: ?M2tsAudioInterval,

    /// When set, enforces that Encoder Boundary Points do not come within the
    /// specified time interval of each other by looking ahead at input video. If
    /// another EBP is going to come in within the specified time interval, the
    /// current EBP is not emitted, and the segment is "stretched" to the next
    /// marker. The lookahead value does not add latency to the system. The Live
    /// Event must be configured elsewhere to create sufficient latency to make the
    /// lookahead accurate.
    ebp_lookahead_ms: ?i32,

    /// Controls placement of EBP on Audio PIDs. If set to videoAndAudioPids, EBP
    /// markers will be placed on the video PID and all audio PIDs. If set to
    /// videoPid, EBP markers will be placed on only the video PID.
    ebp_placement: ?M2tsEbpPlacement,

    /// This field is unused and deprecated.
    ecm_pid: ?[]const u8,

    /// Include or exclude the ES Rate field in the PES header.
    es_rate_in_pes: ?M2tsEsRateInPes,

    /// Packet Identifier (PID) for input source ETV Platform data to this output.
    /// Can be entered as a decimal or hexadecimal value. Valid values are 32 (or
    /// 0x20)..8182 (or 0x1ff6).
    etv_platform_pid: ?[]const u8,

    /// Packet Identifier (PID) for input source ETV Signal data to this output. Can
    /// be entered as a decimal or hexadecimal value. Valid values are 32 (or
    /// 0x20)..8182 (or 0x1ff6).
    etv_signal_pid: ?[]const u8,

    /// The length in seconds of each fragment. Only used with EBP markers.
    fragment_time: ?f64,

    /// If set to passthrough, passes any KLV data from the input source to this
    /// output.
    klv: ?M2tsKlv,

    /// Packet Identifier (PID) for input source KLV data to this output. Multiple
    /// values are accepted, and can be entered in ranges and/or by comma
    /// separation. Can be entered as decimal or hexadecimal values. Each PID
    /// specified must be in the range of 32 (or 0x20)..8182 (or 0x1ff6).
    klv_data_pids: ?[]const u8,

    /// If set to passthrough, Nielsen inaudible tones for media tracking will be
    /// detected in the input audio and an equivalent ID3 tag will be inserted in
    /// the output.
    nielsen_id_3_behavior: ?M2tsNielsenId3Behavior,

    /// Value in bits per second of extra null packets to insert into the transport
    /// stream. This can be used if a downstream encryption system requires periodic
    /// null packets.
    null_packet_bitrate: ?f64,

    /// The number of milliseconds between instances of this table in the output
    /// transport stream. Valid values are 0, 10..1000.
    pat_interval: ?i32,

    /// When set to pcrEveryPesPacket, a Program Clock Reference value is inserted
    /// for every Packetized Elementary Stream (PES) header. This parameter is
    /// effective only when the PCR PID is the same as the video or audio elementary
    /// stream.
    pcr_control: ?M2tsPcrControl,

    /// Maximum time in milliseconds between Program Clock Reference (PCRs) inserted
    /// into the transport stream.
    pcr_period: ?i32,

    /// Packet Identifier (PID) of the Program Clock Reference (PCR) in the
    /// transport stream. When no value is given, the encoder will assign the same
    /// value as the Video PID. Can be entered as a decimal or hexadecimal value.
    /// Valid values are 32 (or 0x20)..8182 (or 0x1ff6).
    pcr_pid: ?[]const u8,

    /// The number of milliseconds between instances of this table in the output
    /// transport stream. Valid values are 0, 10..1000.
    pmt_interval: ?i32,

    /// Packet Identifier (PID) for the Program Map Table (PMT) in the transport
    /// stream. Can be entered as a decimal or hexadecimal value. Valid values are
    /// 32 (or 0x20)..8182 (or 0x1ff6).
    pmt_pid: ?[]const u8,

    /// The value of the program number field in the Program Map Table.
    program_num: ?i32,

    /// When vbr, does not insert null packets into transport stream to fill
    /// specified bitrate. The bitrate setting acts as the maximum bitrate when vbr
    /// is set.
    rate_mode: ?M2tsRateMode,

    /// Packet Identifier (PID) for input source SCTE-27 data to this output.
    /// Multiple values are accepted, and can be entered in ranges and/or by comma
    /// separation. Can be entered as decimal or hexadecimal values. Each PID
    /// specified must be in the range of 32 (or 0x20)..8182 (or 0x1ff6).
    scte_27_pids: ?[]const u8,

    /// Optionally pass SCTE-35 signals from the input source to this output.
    scte_35_control: ?M2tsScte35Control,

    /// Packet Identifier (PID) of the SCTE-35 stream in the transport stream. Can
    /// be entered as a decimal or hexadecimal value. Valid values are 32 (or
    /// 0x20)..8182 (or 0x1ff6).
    scte_35_pid: ?[]const u8,

    /// Defines the amount SCTE-35 preroll will be increased (in milliseconds) on
    /// the output. Preroll is the amount of time between the presence of a SCTE-35
    /// indication in a transport stream and the PTS of the video frame it
    /// references. Zero means don't add pullup (it doesn't mean set the preroll to
    /// zero). Negative pullup is not supported, which means that you can't make the
    /// preroll shorter. Be aware that latency in the output will increase by the
    /// pullup amount.
    scte_35_preroll_pullup_milliseconds: ?f64,

    /// Inserts segmentation markers at each segmentationTime period. raiSegstart
    /// sets the Random Access Indicator bit in the adaptation field. raiAdapt sets
    /// the RAI bit and adds the current timecode in the private data bytes.
    /// psiSegstart inserts PAT and PMT tables at the start of segments. ebp adds
    /// Encoder Boundary Point information to the adaptation field as per OpenCable
    /// specification OC-SP-EBP-I01-130118. ebpLegacy adds Encoder Boundary Point
    /// information to the adaptation field using a legacy proprietary format.
    segmentation_markers: ?M2tsSegmentationMarkers,

    /// The segmentation style parameter controls how segmentation markers are
    /// inserted into the transport stream. With avails, it is possible that
    /// segments may be truncated, which can influence where future segmentation
    /// markers are inserted.
    ///
    /// When a segmentation style of "resetCadence" is selected and a segment is
    /// truncated due to an avail, we will reset the segmentation cadence. This
    /// means the subsequent segment will have a duration of $segmentationTime
    /// seconds.
    ///
    /// When a segmentation style of "maintainCadence" is selected and a segment is
    /// truncated due to an avail, we will not reset the segmentation cadence. This
    /// means the subsequent segment will likely be truncated as well. However, all
    /// segments after that will have a duration of $segmentationTime seconds. Note
    /// that EBP lookahead is a slight exception to this rule.
    segmentation_style: ?M2tsSegmentationStyle,

    /// The length in seconds of each segment. Required unless markers is set to
    /// _none_.
    segmentation_time: ?f64,

    /// When set to passthrough, timed metadata will be passed through from input to
    /// output.
    timed_metadata_behavior: ?M2tsTimedMetadataBehavior,

    /// Packet Identifier (PID) of the timed metadata stream in the transport
    /// stream. Can be entered as a decimal or hexadecimal value. Valid values are
    /// 32 (or 0x20)..8182 (or 0x1ff6).
    timed_metadata_pid: ?[]const u8,

    /// The value of the transport stream ID field in the Program Map Table.
    transport_stream_id: ?i32,

    /// Packet Identifier (PID) of the elementary video stream in the transport
    /// stream. Can be entered as a decimal or hexadecimal value. Valid values are
    /// 32 (or 0x20)..8182 (or 0x1ff6).
    video_pid: ?[]const u8,

    pub const json_field_names = .{
        .absent_input_audio_behavior = "AbsentInputAudioBehavior",
        .arib = "Arib",
        .arib_captions_pid = "AribCaptionsPid",
        .arib_captions_pid_control = "AribCaptionsPidControl",
        .audio_buffer_model = "AudioBufferModel",
        .audio_frames_per_pes = "AudioFramesPerPes",
        .audio_pids = "AudioPids",
        .audio_stream_type = "AudioStreamType",
        .bitrate = "Bitrate",
        .buffer_model = "BufferModel",
        .cc_descriptor = "CcDescriptor",
        .dvb_nit_settings = "DvbNitSettings",
        .dvb_sdt_settings = "DvbSdtSettings",
        .dvb_sub_pids = "DvbSubPids",
        .dvb_tdt_settings = "DvbTdtSettings",
        .dvb_teletext_pid = "DvbTeletextPid",
        .ebif = "Ebif",
        .ebp_audio_interval = "EbpAudioInterval",
        .ebp_lookahead_ms = "EbpLookaheadMs",
        .ebp_placement = "EbpPlacement",
        .ecm_pid = "EcmPid",
        .es_rate_in_pes = "EsRateInPes",
        .etv_platform_pid = "EtvPlatformPid",
        .etv_signal_pid = "EtvSignalPid",
        .fragment_time = "FragmentTime",
        .klv = "Klv",
        .klv_data_pids = "KlvDataPids",
        .nielsen_id_3_behavior = "NielsenId3Behavior",
        .null_packet_bitrate = "NullPacketBitrate",
        .pat_interval = "PatInterval",
        .pcr_control = "PcrControl",
        .pcr_period = "PcrPeriod",
        .pcr_pid = "PcrPid",
        .pmt_interval = "PmtInterval",
        .pmt_pid = "PmtPid",
        .program_num = "ProgramNum",
        .rate_mode = "RateMode",
        .scte_27_pids = "Scte27Pids",
        .scte_35_control = "Scte35Control",
        .scte_35_pid = "Scte35Pid",
        .scte_35_preroll_pullup_milliseconds = "Scte35PrerollPullupMilliseconds",
        .segmentation_markers = "SegmentationMarkers",
        .segmentation_style = "SegmentationStyle",
        .segmentation_time = "SegmentationTime",
        .timed_metadata_behavior = "TimedMetadataBehavior",
        .timed_metadata_pid = "TimedMetadataPid",
        .transport_stream_id = "TransportStreamId",
        .video_pid = "VideoPid",
    };
};

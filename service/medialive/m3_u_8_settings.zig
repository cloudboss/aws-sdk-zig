const M3u8KlvBehavior = @import("m3_u_8_klv_behavior.zig").M3u8KlvBehavior;
const M3u8NielsenId3Behavior = @import("m3_u_8_nielsen_id_3_behavior.zig").M3u8NielsenId3Behavior;
const M3u8PcrControl = @import("m3_u_8_pcr_control.zig").M3u8PcrControl;
const M3u8Scte35Behavior = @import("m3_u_8_scte_35_behavior.zig").M3u8Scte35Behavior;
const M3u8TimedMetadataBehavior = @import("m3_u_8_timed_metadata_behavior.zig").M3u8TimedMetadataBehavior;

/// Settings information for the .m3u8 container
pub const M3u8Settings = struct {
    /// The number of audio frames to insert for each PES packet.
    audio_frames_per_pes: ?i32 = null,

    /// Packet Identifier (PID) of the elementary audio stream(s) in the transport
    /// stream. Multiple values are accepted, and can be entered in ranges and/or by
    /// comma separation. Can be entered as decimal or hexadecimal values.
    audio_pids: ?[]const u8 = null,

    /// This parameter is unused and deprecated.
    ecm_pid: ?[]const u8 = null,

    /// If set to passthrough, passes any KLV data from the input source to this
    /// output.
    klv_behavior: ?M3u8KlvBehavior = null,

    /// Packet Identifier (PID) for input source KLV data to this output. Multiple
    /// values are accepted, and can be entered in ranges and/or by comma
    /// separation. Can be entered as decimal or hexadecimal values. Each PID
    /// specified must be in the range of 32 (or 0x20)..8182 (or 0x1ff6).
    klv_data_pids: ?[]const u8 = null,

    /// If set to passthrough, Nielsen inaudible tones for media tracking will be
    /// detected in the input audio and an equivalent ID3 tag will be inserted in
    /// the output.
    nielsen_id_3_behavior: ?M3u8NielsenId3Behavior = null,

    /// The number of milliseconds between instances of this table in the output
    /// transport stream. A value of \"0\" writes out the PMT once per segment file.
    pat_interval: ?i32 = null,

    /// When set to pcrEveryPesPacket, a Program Clock Reference value is inserted
    /// for every Packetized Elementary Stream (PES) header. This parameter is
    /// effective only when the PCR PID is the same as the video or audio elementary
    /// stream.
    pcr_control: ?M3u8PcrControl = null,

    /// Maximum time in milliseconds between Program Clock References (PCRs)
    /// inserted into the transport stream.
    pcr_period: ?i32 = null,

    /// Packet Identifier (PID) of the Program Clock Reference (PCR) in the
    /// transport stream. When no value is given, the encoder will assign the same
    /// value as the Video PID. Can be entered as a decimal or hexadecimal value.
    pcr_pid: ?[]const u8 = null,

    /// The number of milliseconds between instances of this table in the output
    /// transport stream. A value of \"0\" writes out the PMT once per segment file.
    pmt_interval: ?i32 = null,

    /// Packet Identifier (PID) for the Program Map Table (PMT) in the transport
    /// stream. Can be entered as a decimal or hexadecimal value.
    pmt_pid: ?[]const u8 = null,

    /// The value of the program number field in the Program Map Table.
    program_num: ?i32 = null,

    /// If set to passthrough, passes any SCTE-35 signals from the input source to
    /// this output.
    scte_35_behavior: ?M3u8Scte35Behavior = null,

    /// Packet Identifier (PID) of the SCTE-35 stream in the transport stream. Can
    /// be entered as a decimal or hexadecimal value.
    scte_35_pid: ?[]const u8 = null,

    /// Set to PASSTHROUGH to enable ID3 metadata insertion. To include metadata,
    /// you configure other parameters in the output group or individual outputs, or
    /// you add an ID3 action to the channel schedule.
    timed_metadata_behavior: ?M3u8TimedMetadataBehavior = null,

    /// Packet Identifier (PID) of the timed metadata stream in the transport
    /// stream. Can be entered as a decimal or hexadecimal value. Valid values are
    /// 32 (or 0x20)..8182 (or 0x1ff6).
    timed_metadata_pid: ?[]const u8 = null,

    /// The value of the transport stream ID field in the Program Map Table.
    transport_stream_id: ?i32 = null,

    /// Packet Identifier (PID) of the elementary video stream in the transport
    /// stream. Can be entered as a decimal or hexadecimal value.
    video_pid: ?[]const u8 = null,

    pub const json_field_names = .{
        .audio_frames_per_pes = "AudioFramesPerPes",
        .audio_pids = "AudioPids",
        .ecm_pid = "EcmPid",
        .klv_behavior = "KlvBehavior",
        .klv_data_pids = "KlvDataPids",
        .nielsen_id_3_behavior = "NielsenId3Behavior",
        .pat_interval = "PatInterval",
        .pcr_control = "PcrControl",
        .pcr_period = "PcrPeriod",
        .pcr_pid = "PcrPid",
        .pmt_interval = "PmtInterval",
        .pmt_pid = "PmtPid",
        .program_num = "ProgramNum",
        .scte_35_behavior = "Scte35Behavior",
        .scte_35_pid = "Scte35Pid",
        .timed_metadata_behavior = "TimedMetadataBehavior",
        .timed_metadata_pid = "TimedMetadataPid",
        .transport_stream_id = "TransportStreamId",
        .video_pid = "VideoPid",
    };
};

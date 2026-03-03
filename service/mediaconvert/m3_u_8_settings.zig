const M3u8AudioDuration = @import("m3_u_8_audio_duration.zig").M3u8AudioDuration;
const M3u8DataPtsControl = @import("m3_u_8_data_pts_control.zig").M3u8DataPtsControl;
const M3u8NielsenId3 = @import("m3_u_8_nielsen_id_3.zig").M3u8NielsenId3;
const M3u8PcrControl = @import("m3_u_8_pcr_control.zig").M3u8PcrControl;
const TsPtsOffset = @import("ts_pts_offset.zig").TsPtsOffset;
const M3u8Scte35Source = @import("m3_u_8_scte_35_source.zig").M3u8Scte35Source;
const TimedMetadata = @import("timed_metadata.zig").TimedMetadata;

/// These settings relate to the MPEG-2 transport stream (MPEG2-TS) container
/// for the MPEG2-TS segments in your HLS outputs.
pub const M3u8Settings = struct {
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
    audio_duration: ?M3u8AudioDuration = null,

    /// The number of audio frames to insert for each PES packet.
    audio_frames_per_pes: ?i32 = null,

    /// Packet Identifier (PID) of the elementary audio stream(s) in the transport
    /// stream. Multiple values are accepted, and can be entered in ranges and/or by
    /// comma separation.
    audio_pids: ?[]const i32 = null,

    /// Manually specify the difference in PTS offset that will be applied to the
    /// audio track, in seconds or milliseconds, when you set PTS offset to Seconds
    /// or Milliseconds. Enter an integer from -10000 to 10000. Leave blank to keep
    /// the default value 0.
    audio_pts_offset_delta: ?i32 = null,

    /// If you select ALIGN_TO_VIDEO, MediaConvert writes captions and data packets
    /// with Presentation Timestamp (PTS) values greater than or equal to the first
    /// video packet PTS (MediaConvert drops captions and data packets with lesser
    /// PTS values). Keep the default value AUTO to allow all PTS values.
    data_pts_control: ?M3u8DataPtsControl = null,

    /// Specify the maximum time, in milliseconds, between Program Clock References
    /// (PCRs) inserted into the transport stream.
    max_pcr_interval: ?i32 = null,

    /// If INSERT, Nielsen inaudible tones for media tracking will be detected in
    /// the input audio and an equivalent ID3 tag will be inserted in the output.
    nielsen_id_3: ?M3u8NielsenId3 = null,

    /// The number of milliseconds between instances of this table in the output
    /// transport stream.
    pat_interval: ?i32 = null,

    /// When set to PCR_EVERY_PES_PACKET a Program Clock Reference value is inserted
    /// for every Packetized Elementary Stream (PES) header. This parameter is
    /// effective only when the PCR PID is the same as the video or audio elementary
    /// stream.
    pcr_control: ?M3u8PcrControl = null,

    /// Packet Identifier (PID) of the Program Clock Reference (PCR) in the
    /// transport stream. When no value is given, the encoder will assign the same
    /// value as the Video PID.
    pcr_pid: ?i32 = null,

    /// The number of milliseconds between instances of this table in the output
    /// transport stream.
    pmt_interval: ?i32 = null,

    /// Packet Identifier (PID) for the Program Map Table (PMT) in the transport
    /// stream.
    pmt_pid: ?i32 = null,

    /// Packet Identifier (PID) of the private metadata stream in the transport
    /// stream.
    private_metadata_pid: ?i32 = null,

    /// The value of the program number field in the Program Map Table.
    program_number: ?i32 = null,

    /// Manually specify the initial PTS offset, in seconds, when you set PTS offset
    /// to Seconds. Enter an integer from 0 to 3600. Leave blank to keep the default
    /// value 2.
    pts_offset: ?i32 = null,

    /// Specify the initial presentation timestamp (PTS) offset for your transport
    /// stream output. To let MediaConvert automatically determine the initial PTS
    /// offset: Keep the default value, Auto. We recommend that you choose Auto for
    /// the widest player compatibility. The initial PTS will be at least two
    /// seconds and vary depending on your output's bitrate, HRD buffer size and HRD
    /// buffer initial fill percentage. To manually specify an initial PTS offset:
    /// Choose Seconds or Milliseconds. Then specify the number of seconds or
    /// milliseconds with PTS offset.
    pts_offset_mode: ?TsPtsOffset = null,

    /// Packet Identifier (PID) of the SCTE-35 stream in the transport stream.
    scte_35_pid: ?i32 = null,

    /// For SCTE-35 markers from your input-- Choose Passthrough if you want SCTE-35
    /// markers that appear in your input to also appear in this output. Choose None
    /// if you don't want SCTE-35 markers in this output. For SCTE-35 markers from
    /// an ESAM XML document-- Choose None if you don't want manifest conditioning.
    /// Choose Passthrough and choose Ad markers if you do want manifest
    /// conditioning. In both cases, also provide the ESAM XML as a string in the
    /// setting Signal processing notification XML.
    scte_35_source: ?M3u8Scte35Source = null,

    /// Set ID3 metadata to Passthrough to include ID3 metadata in this output. This
    /// includes ID3 metadata from the following features: ID3 timestamp period, and
    /// Custom ID3 metadata inserter. To exclude this ID3 metadata in this output:
    /// set ID3 metadata to None or leave blank.
    timed_metadata: ?TimedMetadata = null,

    /// Packet Identifier (PID) of the ID3 metadata stream in the transport stream.
    timed_metadata_pid: ?i32 = null,

    /// The value of the transport stream ID field in the Program Map Table.
    transport_stream_id: ?i32 = null,

    /// Packet Identifier (PID) of the elementary video stream in the transport
    /// stream.
    video_pid: ?i32 = null,

    pub const json_field_names = .{
        .audio_duration = "AudioDuration",
        .audio_frames_per_pes = "AudioFramesPerPes",
        .audio_pids = "AudioPids",
        .audio_pts_offset_delta = "AudioPtsOffsetDelta",
        .data_pts_control = "DataPTSControl",
        .max_pcr_interval = "MaxPcrInterval",
        .nielsen_id_3 = "NielsenId3",
        .pat_interval = "PatInterval",
        .pcr_control = "PcrControl",
        .pcr_pid = "PcrPid",
        .pmt_interval = "PmtInterval",
        .pmt_pid = "PmtPid",
        .private_metadata_pid = "PrivateMetadataPid",
        .program_number = "ProgramNumber",
        .pts_offset = "PtsOffset",
        .pts_offset_mode = "PtsOffsetMode",
        .scte_35_pid = "Scte35Pid",
        .scte_35_source = "Scte35Source",
        .timed_metadata = "TimedMetadata",
        .timed_metadata_pid = "TimedMetadataPid",
        .transport_stream_id = "TransportStreamId",
        .video_pid = "VideoPid",
    };
};

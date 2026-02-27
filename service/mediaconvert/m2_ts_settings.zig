const M2tsAudioBufferModel = @import("m2_ts_audio_buffer_model.zig").M2tsAudioBufferModel;
const M2tsAudioDuration = @import("m2_ts_audio_duration.zig").M2tsAudioDuration;
const M2tsBufferModel = @import("m2_ts_buffer_model.zig").M2tsBufferModel;
const M2tsDataPtsControl = @import("m2_ts_data_pts_control.zig").M2tsDataPtsControl;
const DvbNitSettings = @import("dvb_nit_settings.zig").DvbNitSettings;
const DvbSdtSettings = @import("dvb_sdt_settings.zig").DvbSdtSettings;
const DvbTdtSettings = @import("dvb_tdt_settings.zig").DvbTdtSettings;
const M2tsEbpAudioInterval = @import("m2_ts_ebp_audio_interval.zig").M2tsEbpAudioInterval;
const M2tsEbpPlacement = @import("m2_ts_ebp_placement.zig").M2tsEbpPlacement;
const M2tsEsRateInPes = @import("m2_ts_es_rate_in_pes.zig").M2tsEsRateInPes;
const M2tsForceTsVideoEbpOrder = @import("m2_ts_force_ts_video_ebp_order.zig").M2tsForceTsVideoEbpOrder;
const M2tsKlvMetadata = @import("m2_ts_klv_metadata.zig").M2tsKlvMetadata;
const M2tsNielsenId3 = @import("m2_ts_nielsen_id_3.zig").M2tsNielsenId3;
const M2tsPcrControl = @import("m2_ts_pcr_control.zig").M2tsPcrControl;
const M2tsPreventBufferUnderflow = @import("m2_ts_prevent_buffer_underflow.zig").M2tsPreventBufferUnderflow;
const TsPtsOffset = @import("ts_pts_offset.zig").TsPtsOffset;
const M2tsRateMode = @import("m2_ts_rate_mode.zig").M2tsRateMode;
const M2tsScte35Esam = @import("m2_ts_scte_35_esam.zig").M2tsScte35Esam;
const M2tsScte35Source = @import("m2_ts_scte_35_source.zig").M2tsScte35Source;
const M2tsSegmentationMarkers = @import("m2_ts_segmentation_markers.zig").M2tsSegmentationMarkers;
const M2tsSegmentationStyle = @import("m2_ts_segmentation_style.zig").M2tsSegmentationStyle;

/// MPEG-2 TS container settings. These apply to outputs in a File output group
/// when the output's container is MPEG-2 Transport Stream (M2TS). In these
/// assets, data is organized by the program map table (PMT). Each transport
/// stream program contains subsets of data, including audio, video, and
/// metadata. Each of these subsets of data has a numerical label called a
/// packet identifier (PID). Each transport stream program corresponds to one
/// MediaConvert output. The PMT lists the types of data in a program along with
/// their PID. Downstream systems and players use the program map table to look
/// up the PID for each type of data it accesses and then uses the PIDs to
/// locate specific data within the asset.
pub const M2tsSettings = struct {
    /// Selects between the DVB and ATSC buffer models for Dolby Digital audio.
    audio_buffer_model: ?M2tsAudioBufferModel,

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
    audio_duration: ?M2tsAudioDuration,

    /// The number of audio frames to insert for each PES packet.
    audio_frames_per_pes: ?i32,

    /// Specify the packet identifiers (PIDs) for any elementary audio streams you
    /// include in this output. Specify multiple PIDs as a JSON array. Default is
    /// the range 482-492.
    audio_pids: ?[]const i32,

    /// Manually specify the difference in PTS offset that will be applied to the
    /// audio track, in seconds or milliseconds, when you set PTS offset to Seconds
    /// or Milliseconds. Enter an integer from -10000 to 10000. Leave blank to keep
    /// the default value 0.
    audio_pts_offset_delta: ?i32,

    /// Specify the output bitrate of the transport stream in bits per second.
    /// Setting to 0 lets the muxer automatically determine the appropriate bitrate.
    /// Other common values are 3750000, 7500000, and 15000000.
    bitrate: ?i32,

    /// Controls what buffer model to use for accurate interleaving. If set to
    /// MULTIPLEX, use multiplex buffer model. If set to NONE, this can lead to
    /// lower latency, but low-memory devices may not be able to play back the
    /// stream without interruptions.
    buffer_model: ?M2tsBufferModel,

    /// If you select ALIGN_TO_VIDEO, MediaConvert writes captions and data packets
    /// with Presentation Timestamp (PTS) values greater than or equal to the first
    /// video packet PTS (MediaConvert drops captions and data packets with lesser
    /// PTS values). Keep the default value to allow all PTS values.
    data_pts_control: ?M2tsDataPtsControl,

    /// Use these settings to insert a DVB Network Information Table (NIT) in the
    /// transport stream of this output.
    dvb_nit_settings: ?DvbNitSettings,

    /// Use these settings to insert a DVB Service Description Table (SDT) in the
    /// transport stream of this output.
    dvb_sdt_settings: ?DvbSdtSettings,

    /// Specify the packet identifiers (PIDs) for DVB subtitle data included in this
    /// output. Specify multiple PIDs as a JSON array. Default is the range 460-479.
    dvb_sub_pids: ?[]const i32,

    /// Use these settings to insert a DVB Time and Date Table (TDT) in the
    /// transport stream of this output.
    dvb_tdt_settings: ?DvbTdtSettings,

    /// Specify the packet identifier (PID) for DVB teletext data you include in
    /// this output. Default is 499.
    dvb_teletext_pid: ?i32,

    /// When set to VIDEO_AND_FIXED_INTERVALS, audio EBP markers will be added to
    /// partitions 3 and 4. The interval between these additional markers will be
    /// fixed, and will be slightly shorter than the video EBP marker interval. When
    /// set to VIDEO_INTERVAL, these additional markers will not be inserted. Only
    /// applicable when EBP segmentation markers are is selected
    /// (segmentationMarkers is EBP or EBP_LEGACY).
    ebp_audio_interval: ?M2tsEbpAudioInterval,

    /// Selects which PIDs to place EBP markers on. They can either be placed only
    /// on the video PID, or on both the video PID and all audio PIDs. Only
    /// applicable when EBP segmentation markers are is selected
    /// (segmentationMarkers is EBP or EBP_LEGACY).
    ebp_placement: ?M2tsEbpPlacement,

    /// Controls whether to include the ES Rate field in the PES header.
    es_rate_in_pes: ?M2tsEsRateInPes,

    /// Keep the default value unless you know that your audio EBP markers are
    /// incorrectly appearing before your video EBP markers. To correct this
    /// problem, set this value to Force.
    force_ts_video_ebp_order: ?M2tsForceTsVideoEbpOrder,

    /// The length, in seconds, of each fragment. Only used with EBP markers.
    fragment_time: ?f64,

    /// To include key-length-value metadata in this output: Set KLV metadata
    /// insertion to Passthrough. MediaConvert reads KLV metadata present in your
    /// input and passes it through to the output transport stream. To exclude this
    /// KLV metadata: Set KLV metadata insertion to None or leave blank.
    klv_metadata: ?M2tsKlvMetadata,

    /// Specify the maximum time, in milliseconds, between Program Clock References
    /// (PCRs) inserted into the transport stream.
    max_pcr_interval: ?i32,

    /// When set, enforces that Encoder Boundary Points do not come within the
    /// specified time interval of each other by looking ahead at input video. If
    /// another EBP is going to come in within the specified time interval, the
    /// current EBP is not emitted, and the segment is "stretched" to the next
    /// marker. The lookahead value does not add latency to the system. The Live
    /// Event must be configured elsewhere to create sufficient latency to make the
    /// lookahead accurate.
    min_ebp_interval: ?i32,

    /// If INSERT, Nielsen inaudible tones for media tracking will be detected in
    /// the input audio and an equivalent ID3 tag will be inserted in the output.
    nielsen_id_3: ?M2tsNielsenId3,

    /// Value in bits per second of extra null packets to insert into the transport
    /// stream. This can be used if a downstream encryption system requires periodic
    /// null packets.
    null_packet_bitrate: ?f64,

    /// The number of milliseconds between instances of this table in the output
    /// transport stream.
    pat_interval: ?i32,

    /// When set to PCR_EVERY_PES_PACKET, a Program Clock Reference value is
    /// inserted for every Packetized Elementary Stream (PES) header. This is
    /// effective only when the PCR PID is the same as the video or audio elementary
    /// stream.
    pcr_control: ?M2tsPcrControl,

    /// Specify the packet identifier (PID) for the program clock reference (PCR) in
    /// this output. If you do not specify a value, the service will use the value
    /// for Video PID.
    pcr_pid: ?i32,

    /// Specify the number of milliseconds between instances of the program map
    /// table (PMT) in the output transport stream.
    pmt_interval: ?i32,

    /// Specify the packet identifier (PID) for the program map table (PMT) itself.
    /// Default is 480.
    pmt_pid: ?i32,

    /// Specify whether MediaConvert automatically attempts to prevent decoder
    /// buffer underflows in your transport stream output. Use if you are seeing
    /// decoder buffer underflows in your output and are unable to increase your
    /// transport stream's bitrate. For most workflows: We recommend that you keep
    /// the default value, Disabled. To prevent decoder buffer underflows in your
    /// output, when possible: Choose Enabled. Note that if MediaConvert prevents a
    /// decoder buffer underflow in your output, output video quality is reduced and
    /// your job will take longer to complete.
    prevent_buffer_underflow: ?M2tsPreventBufferUnderflow,

    /// Specify the packet identifier (PID) of the private metadata stream. Default
    /// is 503.
    private_metadata_pid: ?i32,

    /// Use Program number to specify the program number used in the program map
    /// table (PMT) for this output. Default is 1. Program numbers and program map
    /// tables are parts of MPEG-2 transport stream containers, used for organizing
    /// data.
    program_number: ?i32,

    /// Manually specify the initial PTS offset, in seconds, when you set PTS offset
    /// to Seconds. Enter an integer from 0 to 3600. Leave blank to keep the default
    /// value 2.
    pts_offset: ?i32,

    /// Specify the initial presentation timestamp (PTS) offset for your transport
    /// stream output. To let MediaConvert automatically determine the initial PTS
    /// offset: Keep the default value, Auto. We recommend that you choose Auto for
    /// the widest player compatibility. The initial PTS will be at least two
    /// seconds and vary depending on your output's bitrate, HRD buffer size and HRD
    /// buffer initial fill percentage. To manually specify an initial PTS offset:
    /// Choose Seconds or Milliseconds. Then specify the number of seconds or
    /// milliseconds with PTS offset.
    pts_offset_mode: ?TsPtsOffset,

    /// When set to CBR, inserts null packets into transport stream to fill
    /// specified bitrate. When set to VBR, the bitrate setting acts as the maximum
    /// bitrate, but the output will not be padded up to that bitrate.
    rate_mode: ?M2tsRateMode,

    /// Include this in your job settings to put SCTE-35 markers in your HLS and
    /// transport stream outputs at the insertion points that you specify in an ESAM
    /// XML document. Provide the document in the setting SCC XML.
    scte_35_esam: ?M2tsScte35Esam,

    /// Specify the packet identifier (PID) of the SCTE-35 stream in the transport
    /// stream.
    scte_35_pid: ?i32,

    /// For SCTE-35 markers from your input-- Choose Passthrough if you want SCTE-35
    /// markers that appear in your input to also appear in this output. Choose None
    /// if you don't want SCTE-35 markers in this output. For SCTE-35 markers from
    /// an ESAM XML document-- Choose None. Also provide the ESAM XML as a string in
    /// the setting Signal processing notification XML. Also enable ESAM SCTE-35
    /// (include the property scte35Esam).
    scte_35_source: ?M2tsScte35Source,

    /// Inserts segmentation markers at each segmentation_time period. rai_segstart
    /// sets the Random Access Indicator bit in the adaptation field. rai_adapt sets
    /// the RAI bit and adds the current timecode in the private data bytes.
    /// psi_segstart inserts PAT and PMT tables at the start of segments. ebp adds
    /// Encoder Boundary Point information to the adaptation field as per OpenCable
    /// specification OC-SP-EBP-I01-130118. ebp_legacy adds Encoder Boundary Point
    /// information to the adaptation field using a legacy proprietary format.
    segmentation_markers: ?M2tsSegmentationMarkers,

    /// The segmentation style parameter controls how segmentation markers are
    /// inserted into the transport stream. With avails, it is possible that
    /// segments may be truncated, which can influence where future segmentation
    /// markers are inserted. When a segmentation style of "reset_cadence" is
    /// selected and a segment is truncated due to an avail, we will reset the
    /// segmentation cadence. This means the subsequent segment will have a duration
    /// of of $segmentation_time seconds. When a segmentation style of
    /// "maintain_cadence" is selected and a segment is truncated due to an avail,
    /// we will not reset the segmentation cadence. This means the subsequent
    /// segment will likely be truncated as well. However, all segments after that
    /// will have a duration of $segmentation_time seconds. Note that EBP lookahead
    /// is a slight exception to this rule.
    segmentation_style: ?M2tsSegmentationStyle,

    /// Specify the length, in seconds, of each segment. Required unless markers is
    /// set to _none_.
    segmentation_time: ?f64,

    /// Packet Identifier (PID) of the ID3 metadata stream in the transport stream.
    timed_metadata_pid: ?i32,

    /// Specify the ID for the transport stream itself in the program map table for
    /// this output. Transport stream IDs and program map tables are parts of MPEG-2
    /// transport stream containers, used for organizing data.
    transport_stream_id: ?i32,

    /// Specify the packet identifier (PID) of the elementary video stream in the
    /// transport stream.
    video_pid: ?i32,

    pub const json_field_names = .{
        .audio_buffer_model = "AudioBufferModel",
        .audio_duration = "AudioDuration",
        .audio_frames_per_pes = "AudioFramesPerPes",
        .audio_pids = "AudioPids",
        .audio_pts_offset_delta = "AudioPtsOffsetDelta",
        .bitrate = "Bitrate",
        .buffer_model = "BufferModel",
        .data_pts_control = "DataPTSControl",
        .dvb_nit_settings = "DvbNitSettings",
        .dvb_sdt_settings = "DvbSdtSettings",
        .dvb_sub_pids = "DvbSubPids",
        .dvb_tdt_settings = "DvbTdtSettings",
        .dvb_teletext_pid = "DvbTeletextPid",
        .ebp_audio_interval = "EbpAudioInterval",
        .ebp_placement = "EbpPlacement",
        .es_rate_in_pes = "EsRateInPes",
        .force_ts_video_ebp_order = "ForceTsVideoEbpOrder",
        .fragment_time = "FragmentTime",
        .klv_metadata = "KlvMetadata",
        .max_pcr_interval = "MaxPcrInterval",
        .min_ebp_interval = "MinEbpInterval",
        .nielsen_id_3 = "NielsenId3",
        .null_packet_bitrate = "NullPacketBitrate",
        .pat_interval = "PatInterval",
        .pcr_control = "PcrControl",
        .pcr_pid = "PcrPid",
        .pmt_interval = "PmtInterval",
        .pmt_pid = "PmtPid",
        .prevent_buffer_underflow = "PreventBufferUnderflow",
        .private_metadata_pid = "PrivateMetadataPid",
        .program_number = "ProgramNumber",
        .pts_offset = "PtsOffset",
        .pts_offset_mode = "PtsOffsetMode",
        .rate_mode = "RateMode",
        .scte_35_esam = "Scte35Esam",
        .scte_35_pid = "Scte35Pid",
        .scte_35_source = "Scte35Source",
        .segmentation_markers = "SegmentationMarkers",
        .segmentation_style = "SegmentationStyle",
        .segmentation_time = "SegmentationTime",
        .timed_metadata_pid = "TimedMetadataPid",
        .transport_stream_id = "TransportStreamId",
        .video_pid = "VideoPid",
    };
};

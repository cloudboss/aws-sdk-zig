/// Packet identifiers map for a given Multiplex program.
pub const MultiplexProgramPacketIdentifiersMap = struct {
    arib_captions_pid: ?i32,

    audio_pids: ?[]const i32,

    dvb_sub_pids: ?[]const i32,

    dvb_teletext_pid: ?i32,

    dvb_teletext_pids: ?[]const i32,

    ecm_pid: ?i32,

    etv_platform_pid: ?i32,

    etv_signal_pid: ?i32,

    klv_data_pids: ?[]const i32,

    pcr_pid: ?i32,

    pmt_pid: ?i32,

    private_metadata_pid: ?i32,

    scte_27_pids: ?[]const i32,

    scte_35_pid: ?i32,

    smpte_2038_pid: ?i32,

    timed_metadata_pid: ?i32,

    video_pid: ?i32,

    pub const json_field_names = .{
        .arib_captions_pid = "AribCaptionsPid",
        .audio_pids = "AudioPids",
        .dvb_sub_pids = "DvbSubPids",
        .dvb_teletext_pid = "DvbTeletextPid",
        .dvb_teletext_pids = "DvbTeletextPids",
        .ecm_pid = "EcmPid",
        .etv_platform_pid = "EtvPlatformPid",
        .etv_signal_pid = "EtvSignalPid",
        .klv_data_pids = "KlvDataPids",
        .pcr_pid = "PcrPid",
        .pmt_pid = "PmtPid",
        .private_metadata_pid = "PrivateMetadataPid",
        .scte_27_pids = "Scte27Pids",
        .scte_35_pid = "Scte35Pid",
        .smpte_2038_pid = "Smpte2038Pid",
        .timed_metadata_pid = "TimedMetadataPid",
        .video_pid = "VideoPid",
    };
};

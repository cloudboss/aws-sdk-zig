/// Packet identifiers map for a given Multiplex program.
pub const MultiplexProgramPacketIdentifiersMap = struct {
    arib_captions_pid: ?i32 = null,

    audio_pids: ?[]const i32 = null,

    dvb_sub_pids: ?[]const i32 = null,

    dvb_teletext_pid: ?i32 = null,

    dvb_teletext_pids: ?[]const i32 = null,

    ecm_pid: ?i32 = null,

    etv_platform_pid: ?i32 = null,

    etv_signal_pid: ?i32 = null,

    klv_data_pids: ?[]const i32 = null,

    pcr_pid: ?i32 = null,

    pmt_pid: ?i32 = null,

    private_metadata_pid: ?i32 = null,

    scte_27_pids: ?[]const i32 = null,

    scte_35_pid: ?i32 = null,

    smpte_2038_pid: ?i32 = null,

    timed_metadata_pid: ?i32 = null,

    video_pid: ?i32 = null,

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

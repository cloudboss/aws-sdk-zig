pub const Protocol = enum {
    zixi_push,
    rtp_fec,
    rtp,
    zixi_pull,
    rist,
    st_2110_jpegxs,
    cdi,
    srt_listener,
    srt_caller,
    fujitsu_qos,
    udp,
    ndi_speed_hq,

    pub const json_field_names = .{
        .zixi_push = "zixi_push",
        .rtp_fec = "rtp_fec",
        .rtp = "rtp",
        .zixi_pull = "zixi_pull",
        .rist = "rist",
        .st_2110_jpegxs = "st2110_jpegxs",
        .cdi = "cdi",
        .srt_listener = "srt_listener",
        .srt_caller = "srt_caller",
        .fujitsu_qos = "fujitsu_qos",
        .udp = "udp",
        .ndi_speed_hq = "ndi_speed_hq",
    };
};

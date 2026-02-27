/// When set to PCR_EVERY_PES_PACKET, a Program Clock Reference value is
/// inserted for every Packetized Elementary Stream (PES) header. This is
/// effective only when the PCR PID is the same as the video or audio elementary
/// stream.
pub const M2tsPcrControl = enum {
    pcr_every_pes_packet,
    configured_pcr_period,

    pub const json_field_names = .{
        .pcr_every_pes_packet = "PCR_EVERY_PES_PACKET",
        .configured_pcr_period = "CONFIGURED_PCR_PERIOD",
    };
};

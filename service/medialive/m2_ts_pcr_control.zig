/// M2ts Pcr Control
pub const M2tsPcrControl = enum {
    configured_pcr_period,
    pcr_every_pes_packet,

    pub const json_field_names = .{
        .configured_pcr_period = "CONFIGURED_PCR_PERIOD",
        .pcr_every_pes_packet = "PCR_EVERY_PES_PACKET",
    };
};

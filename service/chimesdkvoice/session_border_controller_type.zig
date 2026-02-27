pub const SessionBorderControllerType = enum {
    ribbon_sbc,
    oracle_acme_packet_sbc,
    avaya_sbce,
    cisco_unified_border_element,
    audiocodes_mediant_sbc,

    pub const json_field_names = .{
        .ribbon_sbc = "RIBBON_SBC",
        .oracle_acme_packet_sbc = "ORACLE_ACME_PACKET_SBC",
        .avaya_sbce = "AVAYA_SBCE",
        .cisco_unified_border_element = "CISCO_UNIFIED_BORDER_ELEMENT",
        .audiocodes_mediant_sbc = "AUDIOCODES_MEDIANT_SBC",
    };
};

pub const ContactCenterSystemType = enum {
    genesys_engage_on_premises,
    avaya_aura_call_center_elite,
    avaya_aura_contact_center,
    cisco_unified_contact_center_enterprise,

    pub const json_field_names = .{
        .genesys_engage_on_premises = "GENESYS_ENGAGE_ON_PREMISES",
        .avaya_aura_call_center_elite = "AVAYA_AURA_CALL_CENTER_ELITE",
        .avaya_aura_contact_center = "AVAYA_AURA_CONTACT_CENTER",
        .cisco_unified_contact_center_enterprise = "CISCO_UNIFIED_CONTACT_CENTER_ENTERPRISE",
    };
};

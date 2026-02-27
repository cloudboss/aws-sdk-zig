pub const PhoneNumberAssociationName = enum {
    account_id,
    user_id,
    voice_connector_id,
    voice_connector_group_id,
    sip_rule_id,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .user_id = "UserId",
        .voice_connector_id = "VoiceConnectorId",
        .voice_connector_group_id = "VoiceConnectorGroupId",
        .sip_rule_id = "SipRuleId",
    };
};

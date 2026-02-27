pub const IntegrationType = enum {
    send_findings_to_security_hub,
    receive_findings_from_security_hub,
    update_findings_in_security_hub,

    pub const json_field_names = .{
        .send_findings_to_security_hub = "SEND_FINDINGS_TO_SECURITY_HUB",
        .receive_findings_from_security_hub = "RECEIVE_FINDINGS_FROM_SECURITY_HUB",
        .update_findings_in_security_hub = "UPDATE_FINDINGS_IN_SECURITY_HUB",
    };
};

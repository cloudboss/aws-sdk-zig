pub const SipRuleTriggerType = enum {
    to_phone_number,
    request_uri_hostname,

    pub const json_field_names = .{
        .to_phone_number = "ToPhoneNumber",
        .request_uri_hostname = "RequestUriHostname",
    };
};

/// The logging configuration of a SIP media application.
pub const SipMediaApplicationLoggingConfiguration = struct {
    /// Enables message logging for the specified SIP media application.
    enable_sip_media_application_message_logs: ?bool = null,

    pub const json_field_names = .{
        .enable_sip_media_application_message_logs = "EnableSipMediaApplicationMessageLogs",
    };
};

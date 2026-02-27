/// The logging configuration associated with an Amazon Chime SDK Voice
/// Connector.
/// Specifies whether SIP message logs can be sent to Amazon CloudWatch Logs.
pub const LoggingConfiguration = struct {
    /// Enables or disables media metrics logging.
    enable_media_metric_logs: ?bool,

    /// Boolean that enables sending SIP message logs to Amazon CloudWatch.
    enable_sip_logs: ?bool,

    pub const json_field_names = .{
        .enable_media_metric_logs = "EnableMediaMetricLogs",
        .enable_sip_logs = "EnableSIPLogs",
    };
};

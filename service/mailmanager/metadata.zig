/// The metadata about the email.
pub const Metadata = struct {
    /// The name of the configuration set used when sent through a configuration set
    /// with archiving enabled.
    configuration_set: ?[]const u8 = null,

    /// The ID of the ingress endpoint through which the email was received.
    ingress_point_id: ?[]const u8 = null,

    /// The ID of the rule set that processed the email.
    rule_set_id: ?[]const u8 = null,

    /// The name of the host from which the email was received.
    sender_hostname: ?[]const u8 = null,

    /// The IP address of the host from which the email was received.
    sender_ip_address: ?[]const u8 = null,

    /// The name of the API call used when sent through a configuration set with
    /// archiving enabled.
    sending_method: ?[]const u8 = null,

    /// The name of the dedicated IP pool used when sent through a configuration set
    /// with archiving enabled.
    sending_pool: ?[]const u8 = null,

    /// Specifies the archived email source, identified by either a Rule Set's ARN
    /// with an Archive action, or a Configuration Set's Archive ARN.
    source_arn: ?[]const u8 = null,

    /// The identity name used to authorize the sending action when sent through a
    /// configuration set with archiving enabled.
    source_identity: ?[]const u8 = null,

    /// The timestamp of when the email was received.
    timestamp: ?i64 = null,

    /// The TLS cipher suite used to communicate with the host from which the email
    /// was received.
    tls_cipher_suite: ?[]const u8 = null,

    /// The TLS protocol used to communicate with the host from which the email was
    /// received.
    tls_protocol: ?[]const u8 = null,

    /// The ID of the traffic policy that was in effect when the email was received.
    traffic_policy_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration_set = "ConfigurationSet",
        .ingress_point_id = "IngressPointId",
        .rule_set_id = "RuleSetId",
        .sender_hostname = "SenderHostname",
        .sender_ip_address = "SenderIpAddress",
        .sending_method = "SendingMethod",
        .sending_pool = "SendingPool",
        .source_arn = "SourceArn",
        .source_identity = "SourceIdentity",
        .timestamp = "Timestamp",
        .tls_cipher_suite = "TlsCipherSuite",
        .tls_protocol = "TlsProtocol",
        .traffic_policy_id = "TrafficPolicyId",
    };
};

pub const KafkaClusterEncryptionInTransitType = enum {
    plaintext,
    tls,

    pub const json_field_names = .{
        .plaintext = "PLAINTEXT",
        .tls = "TLS",
    };
};

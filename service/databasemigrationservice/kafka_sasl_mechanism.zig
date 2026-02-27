pub const KafkaSaslMechanism = enum {
    scram_sha_512,
    plain,

    pub const json_field_names = .{
        .scram_sha_512 = "SCRAM_SHA_512",
        .plain = "PLAIN",
    };
};

pub const KafkaClusterClientAuthenticationType = enum {
    none,
    iam,

    pub const json_field_names = .{
        .none = "NONE",
        .iam = "IAM",
    };
};

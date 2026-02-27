pub const KafkaSslEndpointIdentificationAlgorithm = enum {
    none,
    https,

    pub const json_field_names = .{
        .none = "NONE",
        .https = "HTTPS",
    };
};

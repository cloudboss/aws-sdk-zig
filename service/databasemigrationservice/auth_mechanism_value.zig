pub const AuthMechanismValue = enum {
    default,
    mongodb_cr,
    scram_sha_1,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .mongodb_cr = "MONGODB_CR",
        .scram_sha_1 = "SCRAM_SHA_1",
    };
};

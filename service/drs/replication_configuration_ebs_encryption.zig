pub const ReplicationConfigurationEbsEncryption = enum {
    default,
    custom,
    none,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .custom = "CUSTOM",
        .none = "NONE",
    };
};

pub const PositionConfigurationFec = enum {
    rose,
    none,

    pub const json_field_names = .{
        .rose = "ROSE",
        .none = "NONE",
    };
};

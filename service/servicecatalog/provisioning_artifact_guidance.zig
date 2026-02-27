pub const ProvisioningArtifactGuidance = enum {
    default,
    deprecated,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .deprecated = "DEPRECATED",
    };
};

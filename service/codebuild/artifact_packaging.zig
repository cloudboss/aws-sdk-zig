pub const ArtifactPackaging = enum {
    none,
    zip,

    pub const json_field_names = .{
        .none = "NONE",
        .zip = "ZIP",
    };
};

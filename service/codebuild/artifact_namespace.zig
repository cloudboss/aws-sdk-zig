pub const ArtifactNamespace = enum {
    none,
    build_id,

    pub const json_field_names = .{
        .none = "NONE",
        .build_id = "BUILD_ID",
    };
};

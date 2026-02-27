pub const SoftwareSetUpdateMode = enum {
    use_latest,
    use_desired,

    pub const json_field_names = .{
        .use_latest = "USE_LATEST",
        .use_desired = "USE_DESIRED",
    };
};

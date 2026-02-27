pub const RevisionLocationType = enum {
    s3,
    git_hub,
    string,
    app_spec_content,

    pub const json_field_names = .{
        .s3 = "S3",
        .git_hub = "GitHub",
        .string = "String",
        .app_spec_content = "AppSpecContent",
    };
};

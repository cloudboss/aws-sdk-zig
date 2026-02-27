pub const VendorName = enum {
    github,
    gitlab,
    native_s3,

    pub const json_field_names = .{
        .github = "GITHUB",
        .gitlab = "GITLAB",
        .native_s3 = "NATIVE_S3",
    };
};

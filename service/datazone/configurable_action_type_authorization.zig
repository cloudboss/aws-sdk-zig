pub const ConfigurableActionTypeAuthorization = enum {
    iam,
    https,

    pub const json_field_names = .{
        .iam = "IAM",
        .https = "HTTPS",
    };
};

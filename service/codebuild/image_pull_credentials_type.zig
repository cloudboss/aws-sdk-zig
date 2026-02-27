pub const ImagePullCredentialsType = enum {
    codebuild,
    service_role,

    pub const json_field_names = .{
        .codebuild = "CODEBUILD",
        .service_role = "SERVICE_ROLE",
    };
};

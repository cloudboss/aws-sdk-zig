pub const ImageRepositoryType = enum {
    ecr,
    ecr_public,

    pub const json_field_names = .{
        .ecr = "ECR",
        .ecr_public = "ECR_PUBLIC",
    };
};

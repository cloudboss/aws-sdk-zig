/// A report of a lens review.
pub const LensReviewReport = struct {
    base_64_string: ?[]const u8,

    lens_alias: ?[]const u8,

    /// The ARN for the lens.
    lens_arn: ?[]const u8,

    pub const json_field_names = .{
        .base_64_string = "Base64String",
        .lens_alias = "LensAlias",
        .lens_arn = "LensArn",
    };
};

/// A report of a lens review.
pub const LensReviewReport = struct {
    base_64_string: ?[]const u8 = null,

    lens_alias: ?[]const u8 = null,

    /// The ARN for the lens.
    lens_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .base_64_string = "Base64String",
        .lens_alias = "LensAlias",
        .lens_arn = "LensArn",
    };
};

/// Contains summary information about a managed MicroVM image.
pub const ManagedMicrovmImageSummary = struct {
    /// The timestamp when the managed MicroVM image was created.
    created_at: i64,

    /// The ARN of the managed MicroVM image.
    image_arn: []const u8,

    /// The timestamp when the managed MicroVM image was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .image_arn = "imageArn",
        .updated_at = "updatedAt",
    };
};

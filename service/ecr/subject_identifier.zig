/// An object that identifies an image subject.
pub const SubjectIdentifier = struct {
    /// The digest of the image.
    image_digest: []const u8,

    pub const json_field_names = .{
        .image_digest = "imageDigest",
    };
};

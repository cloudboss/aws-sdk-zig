pub const ImageFailureCode = enum {
    invalid_image_digest,
    invalid_image_tag,
    image_tag_does_not_match_digest,
    image_not_found,
    missing_digest_and_tag,
    image_referenced_by_manifest_list,
    kms_error,

    pub const json_field_names = .{
        .invalid_image_digest = "InvalidImageDigest",
        .invalid_image_tag = "InvalidImageTag",
        .image_tag_does_not_match_digest = "ImageTagDoesNotMatchDigest",
        .image_not_found = "ImageNotFound",
        .missing_digest_and_tag = "MissingDigestAndTag",
        .image_referenced_by_manifest_list = "ImageReferencedByManifestList",
        .kms_error = "KmsError",
    };
};

const aws = @import("aws");

/// Describes the upload.
pub const UploadMetadata = struct {
    /// The signed headers.
    signed_headers: ?[]const aws.map.StringMapEntry = null,

    /// The URL of the upload.
    upload_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .signed_headers = "SignedHeaders",
        .upload_url = "UploadUrl",
    };
};

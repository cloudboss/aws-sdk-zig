const DefaultServerSideEncryption = @import("default_server_side_encryption.zig").DefaultServerSideEncryption;
const Owner = @import("owner.zig").Owner;
const PublicAccess = @import("public_access.zig").PublicAccess;
const S3ObjectDetail = @import("s3_object_detail.zig").S3ObjectDetail;
const Tag = @import("tag.zig").Tag;

/// Contains information on the S3 bucket.
pub const S3BucketDetail = struct {
    /// The Amazon Resource Name (ARN) of the S3 bucket.
    arn: ?[]const u8,

    /// The date and time the bucket was created at.
    created_at: ?i64,

    /// Describes the server side encryption method used in the S3 bucket.
    default_server_side_encryption: ?DefaultServerSideEncryption,

    /// The name of the S3 bucket.
    name: ?[]const u8,

    /// The owner of the S3 bucket.
    owner: ?Owner,

    /// Describes the public access policies that apply to the S3 bucket.
    public_access: ?PublicAccess,

    /// Information about the S3 object that was scanned.
    s3_object_details: ?[]const S3ObjectDetail,

    /// All tags attached to the S3 bucket
    tags: ?[]const Tag,

    /// Describes whether the bucket is a source or destination bucket.
    type: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_at = "CreatedAt",
        .default_server_side_encryption = "DefaultServerSideEncryption",
        .name = "Name",
        .owner = "Owner",
        .public_access = "PublicAccess",
        .s3_object_details = "S3ObjectDetails",
        .tags = "Tags",
        .type = "Type",
    };
};

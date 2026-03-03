const DefaultServerSideEncryption = @import("default_server_side_encryption.zig").DefaultServerSideEncryption;
const Owner = @import("owner.zig").Owner;
const PublicAccess = @import("public_access.zig").PublicAccess;
const S3ObjectDetail = @import("s3_object_detail.zig").S3ObjectDetail;
const Tag = @import("tag.zig").Tag;

/// Contains information on the S3 bucket.
pub const S3BucketDetail = struct {
    /// The Amazon Resource Name (ARN) of the S3 bucket.
    arn: ?[]const u8 = null,

    /// The date and time the bucket was created at.
    created_at: ?i64 = null,

    /// Describes the server side encryption method used in the S3 bucket.
    default_server_side_encryption: ?DefaultServerSideEncryption = null,

    /// The name of the S3 bucket.
    name: ?[]const u8 = null,

    /// The owner of the S3 bucket.
    owner: ?Owner = null,

    /// Describes the public access policies that apply to the S3 bucket.
    public_access: ?PublicAccess = null,

    /// Information about the S3 object that was scanned.
    s3_object_details: ?[]const S3ObjectDetail = null,

    /// All tags attached to the S3 bucket
    tags: ?[]const Tag = null,

    /// Describes whether the bucket is a source or destination bucket.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_at = "CreatedAt",
        .default_server_side_encryption = "DefaultServerSideEncryption",
        .name = "Name",
        .owner = "Owner",
        .public_access = "PublicAccess",
        .s3_object_details = "S3ObjectDetails",
        .tags = "Tags",
        .@"type" = "Type",
    };
};

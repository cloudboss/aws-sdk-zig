const aws = @import("aws");

/// A MediaPackage VOD Asset resource.
pub const AssetShallow = struct {
    /// The ARN of the Asset.
    arn: ?[]const u8,

    /// The time the Asset was initially submitted for Ingest.
    created_at: ?[]const u8,

    /// The unique identifier for the Asset.
    id: ?[]const u8,

    /// The ID of the PackagingGroup for the Asset.
    packaging_group_id: ?[]const u8,

    /// The resource ID to include in SPEKE key requests.
    resource_id: ?[]const u8,

    /// ARN of the source object in S3.
    source_arn: ?[]const u8,

    /// The IAM role ARN used to access the source S3 bucket.
    source_role_arn: ?[]const u8,

    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_at = "CreatedAt",
        .id = "Id",
        .packaging_group_id = "PackagingGroupId",
        .resource_id = "ResourceId",
        .source_arn = "SourceArn",
        .source_role_arn = "SourceRoleArn",
        .tags = "Tags",
    };
};

const aws = @import("aws");

const S3StorageConfiguration = @import("s3_storage_configuration.zig").S3StorageConfiguration;

/// A complex type that describes a location where recorded videos will be
/// stored.
pub const StorageConfiguration = struct {
    /// ARN of the storage configuration.
    arn: []const u8,

    /// Name of the storage configuration.
    name: ?[]const u8,

    /// An S3 destination configuration where recorded videos will be stored.
    s_3: ?S3StorageConfiguration,

    /// Tags attached to the resource. Array of maps, each of the form
    /// `string:string
    /// (key:value)`. See [Best practices and
    /// strategies](https://docs.aws.amazon.com/tag-editor/latest/userguide/best-practices-and-strats.html) in *Tagging AWS Resources and Tag
    /// Editor* for details, including restrictions that apply to tags and "Tag
    /// naming
    /// limits and requirements"; Amazon IVS has no constraints on tags beyond what
    /// is documented
    /// there.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "arn",
        .name = "name",
        .s_3 = "s3",
        .tags = "tags",
    };
};

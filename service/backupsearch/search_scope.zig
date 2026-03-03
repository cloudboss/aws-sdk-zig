const aws = @import("aws");

const BackupCreationTimeFilter = @import("backup_creation_time_filter.zig").BackupCreationTimeFilter;
const ResourceType = @import("resource_type.zig").ResourceType;

/// The search scope is all backup properties input into a search.
pub const SearchScope = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies the backup
    /// resources.
    backup_resource_arns: ?[]const []const u8 = null,

    /// This is the time a backup resource was created.
    backup_resource_creation_time: ?BackupCreationTimeFilter = null,

    /// These are one or more tags on the backup (recovery point).
    backup_resource_tags: ?[]const aws.map.StringMapEntry = null,

    /// The resource types included in a search.
    ///
    /// Eligible resource types include S3 and EBS.
    backup_resource_types: []const ResourceType,

    /// The Amazon Resource Name (ARN) that uniquely identifies the source
    /// resources.
    source_resource_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .backup_resource_arns = "BackupResourceArns",
        .backup_resource_creation_time = "BackupResourceCreationTime",
        .backup_resource_tags = "BackupResourceTags",
        .backup_resource_types = "BackupResourceTypes",
        .source_resource_arns = "SourceResourceArns",
    };
};

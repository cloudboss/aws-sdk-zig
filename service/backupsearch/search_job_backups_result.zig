const ResourceType = @import("resource_type.zig").ResourceType;
const SearchJobState = @import("search_job_state.zig").SearchJobState;

/// This contains the information about recovery points returned in results of a
/// search job.
pub const SearchJobBackupsResult = struct {
    /// This is the creation time of the backup (recovery point).
    backup_creation_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) that uniquely identifies the backup
    /// resources.
    backup_resource_arn: ?[]const u8 = null,

    /// This is the creation time of the backup index.
    index_creation_time: ?i64 = null,

    /// This is the resource type of the search.
    resource_type: ?ResourceType = null,

    /// The Amazon Resource Name (ARN) that uniquely identifies the source
    /// resources.
    source_resource_arn: ?[]const u8 = null,

    /// This is the status of the search job backup result.
    status: ?SearchJobState = null,

    /// This is the status message included with the results.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .backup_creation_time = "BackupCreationTime",
        .backup_resource_arn = "BackupResourceArn",
        .index_creation_time = "IndexCreationTime",
        .resource_type = "ResourceType",
        .source_resource_arn = "SourceResourceArn",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};

const Destination = @import("destination.zig").Destination;

/// Describes the replication configuration for a specific file system.
pub const ReplicationConfigurationDescription = struct {
    /// Describes when the replication configuration was created.
    creation_time: i64,

    /// An array of destination objects. Only one destination object is supported.
    destinations: []const Destination,

    /// The Amazon Resource Name (ARN) of the original source EFS file
    /// system in the replication configuration.
    original_source_file_system_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the current source file system in the
    /// replication configuration.
    source_file_system_arn: []const u8,

    /// The ID of the source Amazon EFS file system that is being replicated.
    source_file_system_id: []const u8,

    /// ID of the Amazon Web Services account in which the source file system
    /// resides.
    source_file_system_owner_id: ?[]const u8,

    /// The Amazon Web Services Region in which the source EFS file system is
    /// located.
    source_file_system_region: []const u8,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .destinations = "Destinations",
        .original_source_file_system_arn = "OriginalSourceFileSystemArn",
        .source_file_system_arn = "SourceFileSystemArn",
        .source_file_system_id = "SourceFileSystemId",
        .source_file_system_owner_id = "SourceFileSystemOwnerId",
        .source_file_system_region = "SourceFileSystemRegion",
    };
};

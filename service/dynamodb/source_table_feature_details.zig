const GlobalSecondaryIndexInfo = @import("global_secondary_index_info.zig").GlobalSecondaryIndexInfo;
const LocalSecondaryIndexInfo = @import("local_secondary_index_info.zig").LocalSecondaryIndexInfo;
const SSEDescription = @import("sse_description.zig").SSEDescription;
const StreamSpecification = @import("stream_specification.zig").StreamSpecification;
const TimeToLiveDescription = @import("time_to_live_description.zig").TimeToLiveDescription;

/// Contains the details of the features enabled on the table when the backup
/// was created.
/// For example, LSIs, GSIs, streams, TTL.
pub const SourceTableFeatureDetails = struct {
    /// Represents the GSI properties for the table when the backup was created. It
    /// includes
    /// the IndexName, KeySchema, Projection, and ProvisionedThroughput for the GSIs
    /// on the
    /// table at the time of backup.
    global_secondary_indexes: ?[]const GlobalSecondaryIndexInfo = null,

    /// Represents the LSI properties for the table when the backup was created. It
    /// includes
    /// the IndexName, KeySchema and Projection for the LSIs on the table at the
    /// time of backup.
    local_secondary_indexes: ?[]const LocalSecondaryIndexInfo = null,

    /// The description of the server-side encryption status on the table when the
    /// backup was
    /// created.
    sse_description: ?SSEDescription = null,

    /// Stream settings on the table when the backup was created.
    stream_description: ?StreamSpecification = null,

    /// Time to Live settings on the table when the backup was created.
    time_to_live_description: ?TimeToLiveDescription = null,

    pub const json_field_names = .{
        .global_secondary_indexes = "GlobalSecondaryIndexes",
        .local_secondary_indexes = "LocalSecondaryIndexes",
        .sse_description = "SSEDescription",
        .stream_description = "StreamDescription",
        .time_to_live_description = "TimeToLiveDescription",
    };
};

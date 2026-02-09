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
    global_secondary_indexes: ?[]const GlobalSecondaryIndexInfo,

    /// Represents the LSI properties for the table when the backup was created. It
    /// includes
    /// the IndexName, KeySchema and Projection for the LSIs on the table at the
    /// time of backup.
    local_secondary_indexes: ?[]const LocalSecondaryIndexInfo,

    /// The description of the server-side encryption status on the table when the
    /// backup was
    /// created.
    sse_description: ?SSEDescription,

    /// Stream settings on the table when the backup was created.
    stream_description: ?StreamSpecification,

    /// Time to Live settings on the table when the backup was created.
    time_to_live_description: ?TimeToLiveDescription,
};

const BlockStoragePerformanceConfiguration = @import("block_storage_performance_configuration.zig").BlockStoragePerformanceConfiguration;
const StorageConfiguration = @import("storage_configuration.zig").StorageConfiguration;

/// The Amazon Elastic Block Store volume configuration used for
/// recommendations.
pub const EbsVolumeConfiguration = struct {
    /// The Amazon Elastic Block Store attachment state.
    attachment_state: ?[]const u8,

    /// The Amazon Elastic Block Store performance configuration.
    performance: ?BlockStoragePerformanceConfiguration,

    /// The disk storage of the Amazon Elastic Block Store volume.
    storage: ?StorageConfiguration,

    pub const json_field_names = .{
        .attachment_state = "attachmentState",
        .performance = "performance",
        .storage = "storage",
    };
};

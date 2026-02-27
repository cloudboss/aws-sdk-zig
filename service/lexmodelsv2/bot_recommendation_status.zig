pub const BotRecommendationStatus = enum {
    processing,
    deleting,
    deleted,
    downloading,
    updating,
    available,
    failed,
    stopping,
    stopped,

    pub const json_field_names = .{
        .processing = "Processing",
        .deleting = "Deleting",
        .deleted = "Deleted",
        .downloading = "Downloading",
        .updating = "Updating",
        .available = "Available",
        .failed = "Failed",
        .stopping = "Stopping",
        .stopped = "Stopped",
    };
};

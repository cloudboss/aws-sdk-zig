const MSKAccessCredentials = @import("msk_access_credentials.zig").MSKAccessCredentials;

/// The parameters for using an MSK stream as a source.
pub const UpdatePipeSourceManagedStreamingKafkaParameters = struct {
    /// The maximum number of records to include in each batch.
    batch_size: ?i32 = null,

    /// The credentials needed to access the resource.
    credentials: ?MSKAccessCredentials = null,

    /// The maximum length of a time to wait for events.
    maximum_batching_window_in_seconds: ?i32 = null,

    pub const json_field_names = .{
        .batch_size = "BatchSize",
        .credentials = "Credentials",
        .maximum_batching_window_in_seconds = "MaximumBatchingWindowInSeconds",
    };
};

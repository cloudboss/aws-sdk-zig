/// Information about a signal.
pub const SignalInformation = struct {
    /// The ID of the data partition this signal is associated with.
    ///
    /// The ID must match one of the IDs provided in `dataPartitions`. This is
    /// accomplished either by specifying a particular data partition ID or by using
    /// `default` for an established default partition. You can establish a
    /// default partition in the `DataPartition` data type.
    ///
    /// If you upload a signal as a condition for a campaign's data partition,
    /// the same signal must be included in `signalsToCollect`.
    ///
    /// Access to certain Amazon Web Services IoT FleetWise features is currently
    /// gated. For more information, see [Amazon Web Services Region and feature
    /// availability](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/fleetwise-regions.html) in the *Amazon Web Services IoT FleetWise Developer Guide*.
    data_partition_id: ?[]const u8 = null,

    /// The maximum number of samples to collect.
    max_sample_count: ?i64 = null,

    /// The minimum duration of time (in milliseconds) between two triggering events
    /// to
    /// collect data.
    ///
    /// If a signal changes often, you might want to collect data at a slower rate.
    minimum_sampling_interval_ms: ?i64 = null,

    /// The name of the signal.
    name: []const u8,

    pub const json_field_names = .{
        .data_partition_id = "dataPartitionId",
        .max_sample_count = "maxSampleCount",
        .minimum_sampling_interval_ms = "minimumSamplingIntervalMs",
        .name = "name",
    };
};

/// Status of edge devices with this model.
pub const EdgeModelStat = struct {
    /// The number of devices that have this model version, a heart beat, and are
    /// currently running.
    active_device_count: i64,

    /// The number of devices that have this model version and have a heart beat.
    connected_device_count: i64,

    /// The name of the model.
    model_name: []const u8,

    /// The model version.
    model_version: []const u8,

    /// The number of devices that have this model version and do not have a heart
    /// beat.
    offline_device_count: i64,

    /// The number of devices with this model version and are producing sample data.
    sampling_device_count: i64,

    pub const json_field_names = .{
        .active_device_count = "ActiveDeviceCount",
        .connected_device_count = "ConnectedDeviceCount",
        .model_name = "ModelName",
        .model_version = "ModelVersion",
        .offline_device_count = "OfflineDeviceCount",
        .sampling_device_count = "SamplingDeviceCount",
    };
};

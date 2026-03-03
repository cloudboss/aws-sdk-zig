const MeasurementProcessingConfig = @import("measurement_processing_config.zig").MeasurementProcessingConfig;

/// Contains an asset measurement property. For more information, see
/// [Measurements](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/asset-properties.html#measurements) in the *IoT SiteWise User Guide*.
pub const Measurement = struct {
    /// The processing configuration for the given measurement property.
    /// You can configure measurements to be kept at the edge or forwarded to the
    /// Amazon Web Services Cloud.
    /// By default, measurements are forwarded to the cloud.
    processing_config: ?MeasurementProcessingConfig = null,

    pub const json_field_names = .{
        .processing_config = "processingConfig",
    };
};

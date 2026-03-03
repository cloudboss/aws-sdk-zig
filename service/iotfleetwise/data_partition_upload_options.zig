/// The upload options for the data partition. If upload options are specified,
/// you must
/// also specify storage options. See
/// [DataPartitionStorageOptions](https://docs.aws.amazon.com/iot-fleetwise/latest/APIReference/API_DataPartitionStorageOptions.html).
///
/// Access to certain Amazon Web Services IoT FleetWise features is currently
/// gated. For more information, see [Amazon Web Services Region and feature
/// availability](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/fleetwise-regions.html) in the *Amazon Web Services IoT FleetWise Developer Guide*.
pub const DataPartitionUploadOptions = struct {
    /// The version of the condition language. Defaults to the most recent condition
    /// language
    /// version.
    condition_language_version: ?i32 = null,

    /// The logical expression used to recognize what data to collect. For example,
    /// `$variable.`Vehicle.OutsideAirTemperature` >= 105.0`.
    expression: []const u8,

    pub const json_field_names = .{
        .condition_language_version = "conditionLanguageVersion",
        .expression = "expression",
    };
};

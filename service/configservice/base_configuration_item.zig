const aws = @import("aws");

const ConfigurationItemStatus = @import("configuration_item_status.zig").ConfigurationItemStatus;
const RecordingFrequency = @import("recording_frequency.zig").RecordingFrequency;
const ResourceType = @import("resource_type.zig").ResourceType;

/// The detailed configurations of a specified resource.
pub const BaseConfigurationItem = struct {
    /// The 12-digit Amazon Web Services account ID associated with the resource.
    account_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the resource.
    arn: ?[]const u8 = null,

    /// The Availability Zone associated with the resource.
    availability_zone: ?[]const u8 = null,

    /// The region where the resource resides.
    aws_region: ?[]const u8 = null,

    /// A JSON-encoded string that contains the contents for the resource
    /// configuration. This string needs to be deserialized using `json.loads()`
    /// before you can access the contents.
    configuration: ?[]const u8 = null,

    /// The time when the recording of configuration changes was initiated for the
    /// resource.
    configuration_item_capture_time: ?i64 = null,

    /// The time when configuration changes for the resource were delivered.
    ///
    /// This field is optional and is not guaranteed to be present in a
    /// configuration item (CI). If you are using daily recording,
    /// this field will be populated. However, if you are using continuous
    /// recording,
    /// this field will be omitted since the delivery time is instantaneous as the
    /// CI is available right away. For more information on daily recording and
    /// continuous recording, see [Recording
    /// Frequency](https://docs.aws.amazon.com/config/latest/developerguide/select-resources.html#select-resources-recording-frequency) in the *Config
    /// Developer Guide*.
    configuration_item_delivery_time: ?i64 = null,

    /// The configuration item status. Valid values include:
    ///
    /// * OK – The resource configuration has been updated.
    ///
    /// * ResourceDiscovered – The resource was newly discovered.
    ///
    /// * ResourceNotRecorded – The resource was discovered, but its configuration
    ///   was not recorded since the recorder doesn't record resources of this type.
    ///
    /// * ResourceDeleted – The resource was deleted
    ///
    /// * ResourceDeletedNotRecorded – The resource was deleted, but its
    ///   configuration was not recorded since the recorder doesn't record resources
    ///   of this type.
    configuration_item_status: ?ConfigurationItemStatus = null,

    /// An identifier that indicates the ordering of the configuration
    /// items of a resource.
    configuration_state_id: ?[]const u8 = null,

    /// The recording frequency that Config uses to record configuration changes for
    /// the resource.
    ///
    /// This field only appears in the API response when `DAILY` recording is
    /// enabled for a resource type.
    /// If this field is not present, `CONTINUOUS` recording is enabled for that
    /// resource type. For more information on daily recording and continuous
    /// recording, see [Recording
    /// Frequency](https://docs.aws.amazon.com/config/latest/developerguide/select-resources.html#select-resources-recording-frequency) in the *Config
    /// Developer Guide*.
    recording_frequency: ?RecordingFrequency = null,

    /// The time stamp when the resource was created.
    resource_creation_time: ?i64 = null,

    /// The ID of the resource (for example., sg-xxxxxx).
    resource_id: ?[]const u8 = null,

    /// The custom name of the resource, if available.
    resource_name: ?[]const u8 = null,

    /// The type of Amazon Web Services resource.
    resource_type: ?ResourceType = null,

    /// A string to string map that contains additional contents for the resource
    /// configuration.Config returns this field for certain
    /// resource types to supplement the information returned for the
    /// `configuration` field.
    ///
    /// This string needs to be deserialized using `json.loads()` before you can
    /// access the contents.
    supplementary_configuration: ?[]const aws.map.StringMapEntry = null,

    /// The version number of the resource configuration.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .arn = "arn",
        .availability_zone = "availabilityZone",
        .aws_region = "awsRegion",
        .configuration = "configuration",
        .configuration_item_capture_time = "configurationItemCaptureTime",
        .configuration_item_delivery_time = "configurationItemDeliveryTime",
        .configuration_item_status = "configurationItemStatus",
        .configuration_state_id = "configurationStateId",
        .recording_frequency = "recordingFrequency",
        .resource_creation_time = "resourceCreationTime",
        .resource_id = "resourceId",
        .resource_name = "resourceName",
        .resource_type = "resourceType",
        .supplementary_configuration = "supplementaryConfiguration",
        .version = "version",
    };
};

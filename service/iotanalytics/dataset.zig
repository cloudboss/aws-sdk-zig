const DatasetAction = @import("dataset_action.zig").DatasetAction;
const DatasetContentDeliveryRule = @import("dataset_content_delivery_rule.zig").DatasetContentDeliveryRule;
const LateDataRule = @import("late_data_rule.zig").LateDataRule;
const RetentionPeriod = @import("retention_period.zig").RetentionPeriod;
const DatasetStatus = @import("dataset_status.zig").DatasetStatus;
const DatasetTrigger = @import("dataset_trigger.zig").DatasetTrigger;
const VersioningConfiguration = @import("versioning_configuration.zig").VersioningConfiguration;

/// Information about a dataset.
pub const Dataset = struct {
    /// The `DatasetAction` objects that automatically create the dataset
    /// contents.
    actions: ?[]const DatasetAction = null,

    /// The ARN of the dataset.
    arn: ?[]const u8 = null,

    /// When dataset contents are created they are delivered to destinations
    /// specified
    /// here.
    content_delivery_rules: ?[]const DatasetContentDeliveryRule = null,

    /// When the dataset was created.
    creation_time: ?i64 = null,

    /// The last time the dataset was updated.
    last_update_time: ?i64 = null,

    /// A list of data rules that send notifications to CloudWatch, when data
    /// arrives late. To specify `lateDataRules`, the dataset must use a
    /// [DeltaTimer](https://docs.aws.amazon.com/iotanalytics/latest/APIReference/API_DeltaTime.html) filter.
    late_data_rules: ?[]const LateDataRule = null,

    /// The name of the dataset.
    name: ?[]const u8 = null,

    /// Optional. How long, in days, message data is kept for the dataset.
    retention_period: ?RetentionPeriod = null,

    /// The status of the dataset.
    status: ?DatasetStatus = null,

    /// The `DatasetTrigger` objects that specify when the dataset is automatically
    /// updated.
    triggers: ?[]const DatasetTrigger = null,

    /// Optional. How many versions of dataset contents are kept. If not specified
    /// or set to null,
    /// only the latest version plus the latest succeeded version (if they are
    /// different) are kept for
    /// the time period specified by the `retentionPeriod` parameter. For more
    /// information,
    /// see [
    /// Keeping Multiple Versions of IoT Analytics
    /// datasets](https://docs.aws.amazon.com/iotanalytics/latest/userguide/getting-started.html#aws-iot-analytics-dataset-versions) in the
    /// *IoT Analytics User Guide*.
    versioning_configuration: ?VersioningConfiguration = null,

    pub const json_field_names = .{
        .actions = "actions",
        .arn = "arn",
        .content_delivery_rules = "contentDeliveryRules",
        .creation_time = "creationTime",
        .last_update_time = "lastUpdateTime",
        .late_data_rules = "lateDataRules",
        .name = "name",
        .retention_period = "retentionPeriod",
        .status = "status",
        .triggers = "triggers",
        .versioning_configuration = "versioningConfiguration",
    };
};

const RecordField = @import("record_field.zig").RecordField;
const OutputFormat = @import("output_format.zig").OutputFormat;
const ConfigurationTemplateDeliveryConfigValues = @import("configuration_template_delivery_config_values.zig").ConfigurationTemplateDeliveryConfigValues;
const DeliveryDestinationType = @import("delivery_destination_type.zig").DeliveryDestinationType;

/// A structure containing information about the deafult settings and available
/// settings that
/// you can use to configure a
/// [delivery](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_Delivery.html) or a
/// [delivery
/// destination](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_DeliveryDestination.html).
pub const ConfigurationTemplate = struct {
    /// The action permissions that a caller needs to have to be able to
    /// successfully create a
    /// delivery source on the desired resource type when calling
    /// [PutDeliverySource](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutDeliverySource.html).
    allowed_action_for_allow_vended_logs_delivery_for_resource: ?[]const u8,

    /// The valid values that a caller can use as field delimiters when calling
    /// [CreateDelivery](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_CreateDelivery.html) or [UpdateDeliveryConfiguration](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_UpdateDeliveryConfiguration.html) on a delivery that delivers in `Plain`,
    /// `W3C`, or `Raw` format.
    allowed_field_delimiters: ?[]const []const u8,

    /// The allowed fields that a caller can use in the `recordFields` parameter of
    /// a
    /// [CreateDelivery](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_CreateDelivery.html) or [UpdateDeliveryConfiguration](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_UpdateDeliveryConfiguration.html) operation.
    allowed_fields: ?[]const RecordField,

    /// The list of delivery destination output formats that are supported by this
    /// log
    /// source.
    allowed_output_formats: ?[]const OutputFormat,

    /// The list of variable fields that can be used in the suffix path of a
    /// delivery that
    /// delivers to an S3 bucket.
    allowed_suffix_path_fields: ?[]const []const u8,

    /// A mapping that displays the default value of each property within a
    /// delivery's
    /// configuration, if it is not specified in the request.
    default_delivery_config_values: ?ConfigurationTemplateDeliveryConfigValues,

    /// A string specifying which destination type this configuration template
    /// applies to.
    delivery_destination_type: ?DeliveryDestinationType,

    /// A string specifying which log type this configuration template applies to.
    log_type: ?[]const u8,

    /// A string specifying which resource type this configuration template applies
    /// to.
    resource_type: ?[]const u8,

    /// A string specifying which service this configuration template applies to.
    /// For more
    /// information about supported services see [Enable logging from
    /// Amazon Web Services
    /// services.](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/AWS-logs-and-resource-policy.html).
    service: ?[]const u8,

    pub const json_field_names = .{
        .allowed_action_for_allow_vended_logs_delivery_for_resource = "allowedActionForAllowVendedLogsDeliveryForResource",
        .allowed_field_delimiters = "allowedFieldDelimiters",
        .allowed_fields = "allowedFields",
        .allowed_output_formats = "allowedOutputFormats",
        .allowed_suffix_path_fields = "allowedSuffixPathFields",
        .default_delivery_config_values = "defaultDeliveryConfigValues",
        .delivery_destination_type = "deliveryDestinationType",
        .log_type = "logType",
        .resource_type = "resourceType",
        .service = "service",
    };
};

const DataCaptureConfigSummary = @import("data_capture_config_summary.zig").DataCaptureConfigSummary;
const EndpointStatus = @import("endpoint_status.zig").EndpointStatus;
const MonitoringSchedule = @import("monitoring_schedule.zig").MonitoringSchedule;
const ProductionVariantSummary = @import("production_variant_summary.zig").ProductionVariantSummary;
const Tag = @import("tag.zig").Tag;

/// A hosted endpoint for real-time inference.
pub const Endpoint = struct {
    /// The time that the endpoint was created.
    creation_time: i64,

    data_capture_config: ?DataCaptureConfigSummary,

    /// The Amazon Resource Name (ARN) of the endpoint.
    endpoint_arn: []const u8,

    /// The endpoint configuration associated with the endpoint.
    endpoint_config_name: []const u8,

    /// The name of the endpoint.
    endpoint_name: []const u8,

    /// The status of the endpoint.
    endpoint_status: EndpointStatus,

    /// If the endpoint failed, the reason it failed.
    failure_reason: ?[]const u8,

    /// The last time the endpoint was modified.
    last_modified_time: i64,

    /// A list of monitoring schedules for the endpoint. For information about model
    /// monitoring, see [Amazon SageMaker Model
    /// Monitor](https://docs.aws.amazon.com/sagemaker/latest/dg/model-monitor.html).
    monitoring_schedules: ?[]const MonitoringSchedule,

    /// A list of the production variants hosted on the endpoint. Each production
    /// variant is a model.
    production_variants: ?[]const ProductionVariantSummary,

    /// A list of the shadow variants hosted on the endpoint. Each shadow variant is
    /// a model in shadow mode with production traffic replicated from the
    /// production variant.
    shadow_production_variants: ?[]const ProductionVariantSummary,

    /// A list of the tags associated with the endpoint. For more information, see
    /// [Tagging Amazon Web Services
    /// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in the *Amazon Web Services General Reference Guide*.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .data_capture_config = "DataCaptureConfig",
        .endpoint_arn = "EndpointArn",
        .endpoint_config_name = "EndpointConfigName",
        .endpoint_name = "EndpointName",
        .endpoint_status = "EndpointStatus",
        .failure_reason = "FailureReason",
        .last_modified_time = "LastModifiedTime",
        .monitoring_schedules = "MonitoringSchedules",
        .production_variants = "ProductionVariants",
        .shadow_production_variants = "ShadowProductionVariants",
        .tags = "Tags",
    };
};

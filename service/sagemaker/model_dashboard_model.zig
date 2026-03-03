const ModelDashboardEndpoint = @import("model_dashboard_endpoint.zig").ModelDashboardEndpoint;
const TransformJob = @import("transform_job.zig").TransformJob;
const Model = @import("model.zig").Model;
const ModelDashboardModelCard = @import("model_dashboard_model_card.zig").ModelDashboardModelCard;
const ModelDashboardMonitoringSchedule = @import("model_dashboard_monitoring_schedule.zig").ModelDashboardMonitoringSchedule;

/// A model displayed in the Amazon SageMaker Model Dashboard.
pub const ModelDashboardModel = struct {
    /// The endpoints that host a model.
    endpoints: ?[]const ModelDashboardEndpoint = null,

    last_batch_transform_job: ?TransformJob = null,

    /// A model displayed in the Model Dashboard.
    model: ?Model = null,

    /// The model card for a model.
    model_card: ?ModelDashboardModelCard = null,

    /// The monitoring schedules for a model.
    monitoring_schedules: ?[]const ModelDashboardMonitoringSchedule = null,

    pub const json_field_names = .{
        .endpoints = "Endpoints",
        .last_batch_transform_job = "LastBatchTransformJob",
        .model = "Model",
        .model_card = "ModelCard",
        .monitoring_schedules = "MonitoringSchedules",
    };
};

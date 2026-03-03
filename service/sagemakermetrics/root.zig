pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const types = @import("types.zig");

pub const BatchGetMetricsInput = @import("batch_get_metrics.zig").BatchGetMetricsInput;
pub const BatchGetMetricsOutput = @import("batch_get_metrics.zig").BatchGetMetricsOutput;
pub const BatchPutMetricsInput = @import("batch_put_metrics.zig").BatchPutMetricsInput;
pub const BatchPutMetricsOutput = @import("batch_put_metrics.zig").BatchPutMetricsOutput;

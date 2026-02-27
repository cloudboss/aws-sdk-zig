const aws = @import("aws");
const std = @import("std");

const batch_get_metrics = @import("batch_get_metrics.zig");
const batch_put_metrics = @import("batch_put_metrics.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "SageMaker Metrics";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Used to retrieve training metrics from SageMaker.
    pub fn batchGetMetrics(self: *Self, allocator: std.mem.Allocator, input: batch_get_metrics.BatchGetMetricsInput, options: batch_get_metrics.Options) !batch_get_metrics.BatchGetMetricsOutput {
        return batch_get_metrics.execute(self, allocator, input, options);
    }

    /// Used to ingest training metrics into SageMaker. These metrics can be
    /// visualized in SageMaker Studio.
    pub fn batchPutMetrics(self: *Self, allocator: std.mem.Allocator, input: batch_put_metrics.BatchPutMetricsInput, options: batch_put_metrics.Options) !batch_put_metrics.BatchPutMetricsOutput {
        return batch_put_metrics.execute(self, allocator, input, options);
    }
};

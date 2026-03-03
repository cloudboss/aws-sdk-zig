const aws = @import("aws");
const std = @import("std");

const list_realtime_contact_analysis_segments = @import("list_realtime_contact_analysis_segments.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Connect Contact Lens";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Provides a list of analysis segments for a real-time analysis session.
    pub fn listRealtimeContactAnalysisSegments(self: *Self, allocator: std.mem.Allocator, input: list_realtime_contact_analysis_segments.ListRealtimeContactAnalysisSegmentsInput, options: list_realtime_contact_analysis_segments.Options) !list_realtime_contact_analysis_segments.ListRealtimeContactAnalysisSegmentsOutput {
        return list_realtime_contact_analysis_segments.execute(self, allocator, input, options);
    }

    pub fn listRealtimeContactAnalysisSegmentsPaginator(self: *Self, params: list_realtime_contact_analysis_segments.ListRealtimeContactAnalysisSegmentsInput) paginator.ListRealtimeContactAnalysisSegmentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};

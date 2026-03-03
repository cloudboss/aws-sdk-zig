const aws = @import("aws");
const std = @import("std");

const get_buyer_dashboard = @import("get_buyer_dashboard.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Marketplace Reporting";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Generates an embedding URL for an Amazon QuickSight dashboard for an
    /// anonymous user.
    ///
    /// This API is available only to Amazon Web Services Organization management
    /// accounts or
    /// delegated administrators registered for the procurement insights
    /// (`procurement-insights.marketplace.amazonaws.com`) feature.
    ///
    /// The following rules apply to a generated URL:
    ///
    /// * It contains a temporary bearer token, valid for 5 minutes after it is
    ///   generated. Once redeemed within that period, it cannot be re-used again.
    ///
    /// * It has a session lifetime of one hour. The 5-minute validity period runs
    ///   separately from the session lifetime.
    pub fn getBuyerDashboard(self: *Self, allocator: std.mem.Allocator, input: get_buyer_dashboard.GetBuyerDashboardInput, options: get_buyer_dashboard.Options) !get_buyer_dashboard.GetBuyerDashboardOutput {
        return get_buyer_dashboard.execute(self, allocator, input, options);
    }
};

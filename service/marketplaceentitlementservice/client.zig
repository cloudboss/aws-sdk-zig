const aws = @import("aws");
const std = @import("std");

const get_entitlements = @import("get_entitlements.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Marketplace Entitlement Service";

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

    /// GetEntitlements retrieves entitlement values for a given product. The
    /// results can be
    /// filtered based on customer identifier, AWS account ID, license ARN, or
    /// product dimensions.
    pub fn getEntitlements(self: *Self, allocator: std.mem.Allocator, input: get_entitlements.GetEntitlementsInput, options: CallOptions) !get_entitlements.GetEntitlementsOutput {
        return get_entitlements.execute(self, allocator, input, options);
    }

    pub fn getEntitlementsPaginator(self: *Self, params: get_entitlements.GetEntitlementsInput) paginator.GetEntitlementsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};

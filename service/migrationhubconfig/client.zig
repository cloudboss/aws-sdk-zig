const aws = @import("aws");
const std = @import("std");

const create_home_region_control = @import("create_home_region_control.zig");
const delete_home_region_control = @import("delete_home_region_control.zig");
const describe_home_region_controls = @import("describe_home_region_controls.zig");
const get_home_region = @import("get_home_region.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "MigrationHub Config";

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

    /// This API sets up the home region for the calling account only.
    pub fn createHomeRegionControl(self: *Self, allocator: std.mem.Allocator, input: create_home_region_control.CreateHomeRegionControlInput, options: CallOptions) !create_home_region_control.CreateHomeRegionControlOutput {
        return create_home_region_control.execute(self, allocator, input, options);
    }

    /// This operation deletes the home region configuration for the calling
    /// account. The operation does not delete discovery or migration tracking data
    /// in the home region.
    pub fn deleteHomeRegionControl(self: *Self, allocator: std.mem.Allocator, input: delete_home_region_control.DeleteHomeRegionControlInput, options: CallOptions) !delete_home_region_control.DeleteHomeRegionControlOutput {
        return delete_home_region_control.execute(self, allocator, input, options);
    }

    /// This API permits filtering on the `ControlId` and `HomeRegion`
    /// fields.
    pub fn describeHomeRegionControls(self: *Self, allocator: std.mem.Allocator, input: describe_home_region_controls.DescribeHomeRegionControlsInput, options: CallOptions) !describe_home_region_controls.DescribeHomeRegionControlsOutput {
        return describe_home_region_controls.execute(self, allocator, input, options);
    }

    /// Returns the calling account’s home region, if configured. This API is used
    /// by other AWS
    /// services to determine the regional endpoint for calling AWS Application
    /// Discovery Service and
    /// Migration Hub. You must call `GetHomeRegion` at least once before you call
    /// any
    /// other AWS Application Discovery Service and AWS Migration Hub APIs, to
    /// obtain the account's
    /// Migration Hub home region.
    pub fn getHomeRegion(self: *Self, allocator: std.mem.Allocator, input: get_home_region.GetHomeRegionInput, options: CallOptions) !get_home_region.GetHomeRegionOutput {
        return get_home_region.execute(self, allocator, input, options);
    }

    pub fn describeHomeRegionControlsPaginator(self: *Self, params: describe_home_region_controls.DescribeHomeRegionControlsInput) paginator.DescribeHomeRegionControlsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};

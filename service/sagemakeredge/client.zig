const aws = @import("aws");
const std = @import("std");

const get_deployments = @import("get_deployments.zig");
const get_device_registration = @import("get_device_registration.zig");
const send_heartbeat = @import("send_heartbeat.zig");
const CallOptions = @import("call_options.zig").CallOptions;

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Sagemaker Edge";

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

    /// Use to get the active deployments from a device.
    pub fn getDeployments(self: *Self, allocator: std.mem.Allocator, input: get_deployments.GetDeploymentsInput, options: CallOptions) !get_deployments.GetDeploymentsOutput {
        return get_deployments.execute(self, allocator, input, options);
    }

    /// Use to check if a device is registered with SageMaker Edge Manager.
    pub fn getDeviceRegistration(self: *Self, allocator: std.mem.Allocator, input: get_device_registration.GetDeviceRegistrationInput, options: CallOptions) !get_device_registration.GetDeviceRegistrationOutput {
        return get_device_registration.execute(self, allocator, input, options);
    }

    /// Use to get the current status of devices registered on SageMaker Edge
    /// Manager.
    pub fn sendHeartbeat(self: *Self, allocator: std.mem.Allocator, input: send_heartbeat.SendHeartbeatInput, options: CallOptions) !send_heartbeat.SendHeartbeatOutput {
        return send_heartbeat.execute(self, allocator, input, options);
    }
};

const aws = @import("aws");
const std = @import("std");

const cancel_task = @import("cancel_task.zig");
const create_task = @import("create_task.zig");
const describe_device = @import("describe_device.zig");
const describe_device_ec_2_instances = @import("describe_device_ec_2_instances.zig");
const describe_execution = @import("describe_execution.zig");
const describe_task = @import("describe_task.zig");
const list_device_resources = @import("list_device_resources.zig");
const list_devices = @import("list_devices.zig");
const list_executions = @import("list_executions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_tasks = @import("list_tasks.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Snow Device Management";

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

    /// Sends a cancel request for a specified task. You can cancel a task only if
    /// it's still in a
    /// `QUEUED` state. Tasks that are already running can't be cancelled.
    ///
    /// A task might still run if it's processed from the queue before the
    /// `CancelTask` operation changes the task's state.
    pub fn cancelTask(self: *Self, allocator: std.mem.Allocator, input: cancel_task.CancelTaskInput, options: CallOptions) !cancel_task.CancelTaskOutput {
        return cancel_task.execute(self, allocator, input, options);
    }

    /// Instructs one or more devices to start a task, such as unlocking or
    /// rebooting.
    pub fn createTask(self: *Self, allocator: std.mem.Allocator, input: create_task.CreateTaskInput, options: CallOptions) !create_task.CreateTaskOutput {
        return create_task.execute(self, allocator, input, options);
    }

    /// Checks device-specific information, such as the device type, software
    /// version, IP
    /// addresses, and lock status.
    pub fn describeDevice(self: *Self, allocator: std.mem.Allocator, input: describe_device.DescribeDeviceInput, options: CallOptions) !describe_device.DescribeDeviceOutput {
        return describe_device.execute(self, allocator, input, options);
    }

    /// Checks the current state of the Amazon EC2 instances. The output is similar
    /// to
    /// `describeDevice`, but the results are sourced from the device cache in the
    /// Amazon Web Services Cloud and include a subset of the available fields.
    pub fn describeDeviceEc2Instances(self: *Self, allocator: std.mem.Allocator, input: describe_device_ec_2_instances.DescribeDeviceEc2InstancesInput, options: CallOptions) !describe_device_ec_2_instances.DescribeDeviceEc2InstancesOutput {
        return describe_device_ec_2_instances.execute(self, allocator, input, options);
    }

    /// Checks the status of a remote task running on one or more target devices.
    pub fn describeExecution(self: *Self, allocator: std.mem.Allocator, input: describe_execution.DescribeExecutionInput, options: CallOptions) !describe_execution.DescribeExecutionOutput {
        return describe_execution.execute(self, allocator, input, options);
    }

    /// Checks the metadata for a given task on a device.
    pub fn describeTask(self: *Self, allocator: std.mem.Allocator, input: describe_task.DescribeTaskInput, options: CallOptions) !describe_task.DescribeTaskOutput {
        return describe_task.execute(self, allocator, input, options);
    }

    /// Returns a list of the Amazon Web Services resources available for a device.
    /// Currently, Amazon EC2 instances are the only supported resource type.
    pub fn listDeviceResources(self: *Self, allocator: std.mem.Allocator, input: list_device_resources.ListDeviceResourcesInput, options: CallOptions) !list_device_resources.ListDeviceResourcesOutput {
        return list_device_resources.execute(self, allocator, input, options);
    }

    /// Returns a list of all devices on your Amazon Web Services account that have
    /// Amazon Web Services Snow Device Management
    /// enabled in the Amazon Web Services Region where the command is run.
    pub fn listDevices(self: *Self, allocator: std.mem.Allocator, input: list_devices.ListDevicesInput, options: CallOptions) !list_devices.ListDevicesOutput {
        return list_devices.execute(self, allocator, input, options);
    }

    /// Returns the status of tasks for one or more target devices.
    pub fn listExecutions(self: *Self, allocator: std.mem.Allocator, input: list_executions.ListExecutionsInput, options: CallOptions) !list_executions.ListExecutionsOutput {
        return list_executions.execute(self, allocator, input, options);
    }

    /// Returns a list of tags for a managed device or task.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Returns a list of tasks that can be filtered by state.
    pub fn listTasks(self: *Self, allocator: std.mem.Allocator, input: list_tasks.ListTasksInput, options: CallOptions) !list_tasks.ListTasksOutput {
        return list_tasks.execute(self, allocator, input, options);
    }

    /// Adds or replaces tags on a device or task.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag from a device or task.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    pub fn listDeviceResourcesPaginator(self: *Self, params: list_device_resources.ListDeviceResourcesInput) paginator.ListDeviceResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDevicesPaginator(self: *Self, params: list_devices.ListDevicesInput) paginator.ListDevicesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listExecutionsPaginator(self: *Self, params: list_executions.ListExecutionsInput) paginator.ListExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTasksPaginator(self: *Self, params: list_tasks.ListTasksInput) paginator.ListTasksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};

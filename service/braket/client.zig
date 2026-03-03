const aws = @import("aws");
const std = @import("std");

const cancel_job = @import("cancel_job.zig");
const cancel_quantum_task = @import("cancel_quantum_task.zig");
const create_job = @import("create_job.zig");
const create_quantum_task = @import("create_quantum_task.zig");
const create_spending_limit = @import("create_spending_limit.zig");
const delete_spending_limit = @import("delete_spending_limit.zig");
const get_device = @import("get_device.zig");
const get_job = @import("get_job.zig");
const get_quantum_task = @import("get_quantum_task.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const search_devices = @import("search_devices.zig");
const search_jobs = @import("search_jobs.zig");
const search_quantum_tasks = @import("search_quantum_tasks.zig");
const search_spending_limits = @import("search_spending_limits.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_spending_limit = @import("update_spending_limit.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Braket";

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

    /// Cancels an Amazon Braket hybrid job.
    pub fn cancelJob(self: *Self, allocator: std.mem.Allocator, input: cancel_job.CancelJobInput, options: CallOptions) !cancel_job.CancelJobOutput {
        return cancel_job.execute(self, allocator, input, options);
    }

    /// Cancels the specified task.
    pub fn cancelQuantumTask(self: *Self, allocator: std.mem.Allocator, input: cancel_quantum_task.CancelQuantumTaskInput, options: CallOptions) !cancel_quantum_task.CancelQuantumTaskOutput {
        return cancel_quantum_task.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Braket hybrid job.
    pub fn createJob(self: *Self, allocator: std.mem.Allocator, input: create_job.CreateJobInput, options: CallOptions) !create_job.CreateJobOutput {
        return create_job.execute(self, allocator, input, options);
    }

    /// Creates a quantum task.
    pub fn createQuantumTask(self: *Self, allocator: std.mem.Allocator, input: create_quantum_task.CreateQuantumTaskInput, options: CallOptions) !create_quantum_task.CreateQuantumTaskOutput {
        return create_quantum_task.execute(self, allocator, input, options);
    }

    /// Creates a spending limit for a specified quantum device. Spending limits
    /// help you control costs by setting maximum amounts that can be spent on
    /// quantum computing tasks within a specified time period. Simulators do not
    /// support spending limits.
    pub fn createSpendingLimit(self: *Self, allocator: std.mem.Allocator, input: create_spending_limit.CreateSpendingLimitInput, options: CallOptions) !create_spending_limit.CreateSpendingLimitOutput {
        return create_spending_limit.execute(self, allocator, input, options);
    }

    /// Deletes an existing spending limit. This operation permanently removes the
    /// spending limit and cannot be undone. After deletion, the associated device
    /// becomes unrestricted for spending.
    pub fn deleteSpendingLimit(self: *Self, allocator: std.mem.Allocator, input: delete_spending_limit.DeleteSpendingLimitInput, options: CallOptions) !delete_spending_limit.DeleteSpendingLimitOutput {
        return delete_spending_limit.execute(self, allocator, input, options);
    }

    /// Retrieves the devices available in Amazon Braket.
    ///
    /// For backwards compatibility with older versions of BraketSchemas, OpenQASM
    /// information is omitted from GetDevice API calls. To get this information the
    /// user-agent needs to present a recent version of the BraketSchemas (1.8.0 or
    /// later). The Braket SDK automatically reports this for you. If you do not see
    /// OpenQASM results in the GetDevice response when using a Braket SDK, you may
    /// need to set AWS_EXECUTION_ENV environment variable to configure user-agent.
    /// See the code examples provided below for how to do this for the AWS CLI,
    /// Boto3, and the Go, Java, and JavaScript/TypeScript SDKs.
    pub fn getDevice(self: *Self, allocator: std.mem.Allocator, input: get_device.GetDeviceInput, options: CallOptions) !get_device.GetDeviceOutput {
        return get_device.execute(self, allocator, input, options);
    }

    /// Retrieves the specified Amazon Braket hybrid job.
    pub fn getJob(self: *Self, allocator: std.mem.Allocator, input: get_job.GetJobInput, options: CallOptions) !get_job.GetJobOutput {
        return get_job.execute(self, allocator, input, options);
    }

    /// Retrieves the specified quantum task.
    pub fn getQuantumTask(self: *Self, allocator: std.mem.Allocator, input: get_quantum_task.GetQuantumTaskInput, options: CallOptions) !get_quantum_task.GetQuantumTaskOutput {
        return get_quantum_task.execute(self, allocator, input, options);
    }

    /// Shows the tags associated with this resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Searches for devices using the specified filters.
    pub fn searchDevices(self: *Self, allocator: std.mem.Allocator, input: search_devices.SearchDevicesInput, options: CallOptions) !search_devices.SearchDevicesOutput {
        return search_devices.execute(self, allocator, input, options);
    }

    /// Searches for Amazon Braket hybrid jobs that match the specified filter
    /// values.
    pub fn searchJobs(self: *Self, allocator: std.mem.Allocator, input: search_jobs.SearchJobsInput, options: CallOptions) !search_jobs.SearchJobsOutput {
        return search_jobs.execute(self, allocator, input, options);
    }

    /// Searches for tasks that match the specified filter values.
    pub fn searchQuantumTasks(self: *Self, allocator: std.mem.Allocator, input: search_quantum_tasks.SearchQuantumTasksInput, options: CallOptions) !search_quantum_tasks.SearchQuantumTasksOutput {
        return search_quantum_tasks.execute(self, allocator, input, options);
    }

    /// Searches and lists spending limits based on specified filters. This
    /// operation supports pagination and allows filtering by various criteria to
    /// find specific spending limits. We recommend using pagination to ensure that
    /// the operation returns quickly and successfully.
    pub fn searchSpendingLimits(self: *Self, allocator: std.mem.Allocator, input: search_spending_limits.SearchSpendingLimitsInput, options: CallOptions) !search_spending_limits.SearchSpendingLimitsOutput {
        return search_spending_limits.execute(self, allocator, input, options);
    }

    /// Add a tag to the specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Remove tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing spending limit. You can modify the spending amount or
    /// time period. Changes take effect immediately.
    pub fn updateSpendingLimit(self: *Self, allocator: std.mem.Allocator, input: update_spending_limit.UpdateSpendingLimitInput, options: CallOptions) !update_spending_limit.UpdateSpendingLimitOutput {
        return update_spending_limit.execute(self, allocator, input, options);
    }

    pub fn searchDevicesPaginator(self: *Self, params: search_devices.SearchDevicesInput) paginator.SearchDevicesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchJobsPaginator(self: *Self, params: search_jobs.SearchJobsInput) paginator.SearchJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchQuantumTasksPaginator(self: *Self, params: search_quantum_tasks.SearchQuantumTasksInput) paginator.SearchQuantumTasksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchSpendingLimitsPaginator(self: *Self, params: search_spending_limits.SearchSpendingLimitsInput) paginator.SearchSpendingLimitsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};

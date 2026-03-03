const aws = @import("aws");
const std = @import("std");

const describe_job_execution = @import("describe_job_execution.zig");
const get_pending_job_executions = @import("get_pending_job_executions.zig");
const start_command_execution = @import("start_command_execution.zig");
const start_next_pending_job_execution = @import("start_next_pending_job_execution.zig");
const update_job_execution = @import("update_job_execution.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "IoT Jobs Data Plane";

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

    /// Gets details of a job execution.
    ///
    /// Requires permission to access the
    /// [DescribeJobExecution](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeJobExecution(self: *Self, allocator: std.mem.Allocator, input: describe_job_execution.DescribeJobExecutionInput, options: describe_job_execution.Options) !describe_job_execution.DescribeJobExecutionOutput {
        return describe_job_execution.execute(self, allocator, input, options);
    }

    /// Gets the list of all jobs for a thing that are not in a terminal status.
    ///
    /// Requires permission to access the
    /// [GetPendingJobExecutions](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn getPendingJobExecutions(self: *Self, allocator: std.mem.Allocator, input: get_pending_job_executions.GetPendingJobExecutionsInput, options: get_pending_job_executions.Options) !get_pending_job_executions.GetPendingJobExecutionsOutput {
        return get_pending_job_executions.execute(self, allocator, input, options);
    }

    /// Using the command created with the `CreateCommand` API, start a command
    /// execution on a specific device.
    pub fn startCommandExecution(self: *Self, allocator: std.mem.Allocator, input: start_command_execution.StartCommandExecutionInput, options: start_command_execution.Options) !start_command_execution.StartCommandExecutionOutput {
        return start_command_execution.execute(self, allocator, input, options);
    }

    /// Gets and starts the next pending (status IN_PROGRESS or QUEUED) job
    /// execution for a
    /// thing.
    ///
    /// Requires permission to access the
    /// [StartNextPendingJobExecution](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn startNextPendingJobExecution(self: *Self, allocator: std.mem.Allocator, input: start_next_pending_job_execution.StartNextPendingJobExecutionInput, options: start_next_pending_job_execution.Options) !start_next_pending_job_execution.StartNextPendingJobExecutionOutput {
        return start_next_pending_job_execution.execute(self, allocator, input, options);
    }

    /// Updates the status of a job execution.
    ///
    /// Requires permission to access the
    /// [UpdateJobExecution](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiotjobsdataplane.html) action.
    pub fn updateJobExecution(self: *Self, allocator: std.mem.Allocator, input: update_job_execution.UpdateJobExecutionInput, options: update_job_execution.Options) !update_job_execution.UpdateJobExecutionOutput {
        return update_job_execution.execute(self, allocator, input, options);
    }
};

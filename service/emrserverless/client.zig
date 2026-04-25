const aws = @import("aws");
const std = @import("std");

const cancel_job_run = @import("cancel_job_run.zig");
const create_application = @import("create_application.zig");
const delete_application = @import("delete_application.zig");
const get_application = @import("get_application.zig");
const get_dashboard_for_job_run = @import("get_dashboard_for_job_run.zig");
const get_job_run = @import("get_job_run.zig");
const get_resource_dashboard = @import("get_resource_dashboard.zig");
const get_session = @import("get_session.zig");
const get_session_endpoint = @import("get_session_endpoint.zig");
const list_applications = @import("list_applications.zig");
const list_job_run_attempts = @import("list_job_run_attempts.zig");
const list_job_runs = @import("list_job_runs.zig");
const list_sessions = @import("list_sessions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const start_application = @import("start_application.zig");
const start_job_run = @import("start_job_run.zig");
const start_session = @import("start_session.zig");
const stop_application = @import("stop_application.zig");
const tag_resource = @import("tag_resource.zig");
const terminate_session = @import("terminate_session.zig");
const untag_resource = @import("untag_resource.zig");
const update_application = @import("update_application.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "EMR Serverless";

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

    /// Cancels a job run.
    pub fn cancelJobRun(self: *Self, allocator: std.mem.Allocator, input: cancel_job_run.CancelJobRunInput, options: CallOptions) !cancel_job_run.CancelJobRunOutput {
        return cancel_job_run.execute(self, allocator, input, options);
    }

    /// Creates an application.
    pub fn createApplication(self: *Self, allocator: std.mem.Allocator, input: create_application.CreateApplicationInput, options: CallOptions) !create_application.CreateApplicationOutput {
        return create_application.execute(self, allocator, input, options);
    }

    /// Deletes an application. An application has to be in a stopped or created
    /// state in order to be deleted.
    pub fn deleteApplication(self: *Self, allocator: std.mem.Allocator, input: delete_application.DeleteApplicationInput, options: CallOptions) !delete_application.DeleteApplicationOutput {
        return delete_application.execute(self, allocator, input, options);
    }

    /// Displays detailed information about a specified application.
    pub fn getApplication(self: *Self, allocator: std.mem.Allocator, input: get_application.GetApplicationInput, options: CallOptions) !get_application.GetApplicationOutput {
        return get_application.execute(self, allocator, input, options);
    }

    /// Creates and returns a URL that you can use to access the application UIs for
    /// a job run.
    ///
    /// For jobs in a running state, the application UI is a live user interface
    /// such as the Spark or Tez web UI. For completed jobs, the application UI is a
    /// persistent application user interface such as the Spark History Server or
    /// persistent Tez UI.
    ///
    /// The URL is valid for one hour after you generate it. To access the
    /// application UI after that hour elapses, you must invoke the API again to
    /// generate a new URL.
    pub fn getDashboardForJobRun(self: *Self, allocator: std.mem.Allocator, input: get_dashboard_for_job_run.GetDashboardForJobRunInput, options: CallOptions) !get_dashboard_for_job_run.GetDashboardForJobRunOutput {
        return get_dashboard_for_job_run.execute(self, allocator, input, options);
    }

    /// Displays detailed information about a job run.
    pub fn getJobRun(self: *Self, allocator: std.mem.Allocator, input: get_job_run.GetJobRunInput, options: CallOptions) !get_job_run.GetJobRunOutput {
        return get_job_run.execute(self, allocator, input, options);
    }

    /// Returns a URL that you can use to access the application UIs for a specified
    /// resource, such as a session.
    ///
    /// For resources in a running state, the application UI is a live user
    /// interface such as the Spark web UI. For terminated resources, the
    /// application UI is a persistent application user interface such as the Spark
    /// History Server.
    ///
    /// The URL is valid for one hour after you generate it. To access the
    /// application UI after that hour elapses, you must invoke the API again to
    /// generate a new URL.
    pub fn getResourceDashboard(self: *Self, allocator: std.mem.Allocator, input: get_resource_dashboard.GetResourceDashboardInput, options: CallOptions) !get_resource_dashboard.GetResourceDashboardOutput {
        return get_resource_dashboard.execute(self, allocator, input, options);
    }

    /// Displays detailed information about a session.
    pub fn getSession(self: *Self, allocator: std.mem.Allocator, input: get_session.GetSessionInput, options: CallOptions) !get_session.GetSessionOutput {
        return get_session.execute(self, allocator, input, options);
    }

    /// Returns the session endpoint URL and a time-limited authentication token for
    /// the specified session. Use the endpoint and token to connect a client to the
    /// session. Call this operation again when the authentication token expires to
    /// obtain a new token.
    pub fn getSessionEndpoint(self: *Self, allocator: std.mem.Allocator, input: get_session_endpoint.GetSessionEndpointInput, options: CallOptions) !get_session_endpoint.GetSessionEndpointOutput {
        return get_session_endpoint.execute(self, allocator, input, options);
    }

    /// Lists applications based on a set of parameters.
    pub fn listApplications(self: *Self, allocator: std.mem.Allocator, input: list_applications.ListApplicationsInput, options: CallOptions) !list_applications.ListApplicationsOutput {
        return list_applications.execute(self, allocator, input, options);
    }

    /// Lists all attempt of a job run.
    pub fn listJobRunAttempts(self: *Self, allocator: std.mem.Allocator, input: list_job_run_attempts.ListJobRunAttemptsInput, options: CallOptions) !list_job_run_attempts.ListJobRunAttemptsOutput {
        return list_job_run_attempts.execute(self, allocator, input, options);
    }

    /// Lists job runs based on a set of parameters.
    pub fn listJobRuns(self: *Self, allocator: std.mem.Allocator, input: list_job_runs.ListJobRunsInput, options: CallOptions) !list_job_runs.ListJobRunsOutput {
        return list_job_runs.execute(self, allocator, input, options);
    }

    /// Lists sessions for the specified application. You can filter sessions by
    /// state and creation time.
    pub fn listSessions(self: *Self, allocator: std.mem.Allocator, input: list_sessions.ListSessionsInput, options: CallOptions) !list_sessions.ListSessionsOutput {
        return list_sessions.execute(self, allocator, input, options);
    }

    /// Lists the tags assigned to the resources.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Starts a specified application and initializes initial capacity if
    /// configured.
    pub fn startApplication(self: *Self, allocator: std.mem.Allocator, input: start_application.StartApplicationInput, options: CallOptions) !start_application.StartApplicationOutput {
        return start_application.execute(self, allocator, input, options);
    }

    /// Starts a job run.
    pub fn startJobRun(self: *Self, allocator: std.mem.Allocator, input: start_job_run.StartJobRunInput, options: CallOptions) !start_job_run.StartJobRunOutput {
        return start_job_run.execute(self, allocator, input, options);
    }

    /// Creates and starts a new session on the specified application. The
    /// application must be in the `STARTED` state or have `AutoStart` enabled, and
    /// have interactive sessions enabled. This operation is supported for EMR
    /// release 7.13.0 and later.
    pub fn startSession(self: *Self, allocator: std.mem.Allocator, input: start_session.StartSessionInput, options: CallOptions) !start_session.StartSessionOutput {
        return start_session.execute(self, allocator, input, options);
    }

    /// Stops a specified application and releases initial capacity if configured.
    /// All scheduled and running jobs must be completed or cancelled before
    /// stopping an application.
    pub fn stopApplication(self: *Self, allocator: std.mem.Allocator, input: stop_application.StopApplicationInput, options: CallOptions) !stop_application.StopApplicationOutput {
        return stop_application.execute(self, allocator, input, options);
    }

    /// Assigns tags to resources. A tag is a label that you assign to an Amazon Web
    /// Services resource. Each tag consists of a key and an optional value, both of
    /// which you define. Tags enable you to categorize your Amazon Web Services
    /// resources by attributes such as purpose, owner, or environment. When you
    /// have many resources of the same type, you can quickly identify a specific
    /// resource based on the tags you've assigned to it.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Terminates the specified session. After you terminate a session, it enters
    /// the `TERMINATING` state and then the `TERMINATED` state. You can still
    /// access the Spark History Server for a terminated session through the
    /// `GetResourceDashboard` operation.
    pub fn terminateSession(self: *Self, allocator: std.mem.Allocator, input: terminate_session.TerminateSessionInput, options: CallOptions) !terminate_session.TerminateSessionOutput {
        return terminate_session.execute(self, allocator, input, options);
    }

    /// Removes tags from resources.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a specified application. An application has to be in a stopped or
    /// created state in order to be updated.
    pub fn updateApplication(self: *Self, allocator: std.mem.Allocator, input: update_application.UpdateApplicationInput, options: CallOptions) !update_application.UpdateApplicationOutput {
        return update_application.execute(self, allocator, input, options);
    }

    pub fn listApplicationsPaginator(self: *Self, params: list_applications.ListApplicationsInput) paginator.ListApplicationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listJobRunAttemptsPaginator(self: *Self, params: list_job_run_attempts.ListJobRunAttemptsInput) paginator.ListJobRunAttemptsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listJobRunsPaginator(self: *Self, params: list_job_runs.ListJobRunsInput) paginator.ListJobRunsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSessionsPaginator(self: *Self, params: list_sessions.ListSessionsInput) paginator.ListSessionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};

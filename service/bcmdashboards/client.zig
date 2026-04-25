const aws = @import("aws");
const std = @import("std");

const create_dashboard = @import("create_dashboard.zig");
const create_scheduled_report = @import("create_scheduled_report.zig");
const delete_dashboard = @import("delete_dashboard.zig");
const delete_scheduled_report = @import("delete_scheduled_report.zig");
const execute_scheduled_report = @import("execute_scheduled_report.zig");
const get_dashboard = @import("get_dashboard.zig");
const get_resource_policy = @import("get_resource_policy.zig");
const get_scheduled_report = @import("get_scheduled_report.zig");
const list_dashboards = @import("list_dashboards.zig");
const list_scheduled_reports = @import("list_scheduled_reports.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_dashboard = @import("update_dashboard.zig");
const update_scheduled_report = @import("update_scheduled_report.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "BCM Dashboards";

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

    /// Creates a new dashboard that can contain multiple widgets displaying cost
    /// and usage data. You can add custom widgets or use predefined widgets,
    /// arranging them in your preferred layout.
    pub fn createDashboard(self: *Self, allocator: std.mem.Allocator, input: create_dashboard.CreateDashboardInput, options: CallOptions) !create_dashboard.CreateDashboardOutput {
        return create_dashboard.execute(self, allocator, input, options);
    }

    /// Creates a new scheduled report for a dashboard. A scheduled report
    /// automatically generates and delivers dashboard snapshots on a recurring
    /// schedule. Reports are delivered within 15 minutes of the scheduled delivery
    /// time.
    pub fn createScheduledReport(self: *Self, allocator: std.mem.Allocator, input: create_scheduled_report.CreateScheduledReportInput, options: CallOptions) !create_scheduled_report.CreateScheduledReportOutput {
        return create_scheduled_report.execute(self, allocator, input, options);
    }

    /// Deletes a specified dashboard. This action cannot be undone.
    pub fn deleteDashboard(self: *Self, allocator: std.mem.Allocator, input: delete_dashboard.DeleteDashboardInput, options: CallOptions) !delete_dashboard.DeleteDashboardOutput {
        return delete_dashboard.execute(self, allocator, input, options);
    }

    /// Deletes a specified scheduled report. This is an irreversible operation.
    pub fn deleteScheduledReport(self: *Self, allocator: std.mem.Allocator, input: delete_scheduled_report.DeleteScheduledReportInput, options: CallOptions) !delete_scheduled_report.DeleteScheduledReportOutput {
        return delete_scheduled_report.execute(self, allocator, input, options);
    }

    /// Triggers an immediate execution of a scheduled report, outside of its
    /// regular schedule. The scheduled report must be in `ENABLED` state. Calling
    /// this operation on a `DISABLED` scheduled report returns a
    /// `ValidationException`.
    ///
    /// If a `clientToken` is provided, the service uses it for idempotency.
    /// Requests with the same client token will not trigger a new execution within
    /// the same minute.
    pub fn executeScheduledReport(self: *Self, allocator: std.mem.Allocator, input: execute_scheduled_report.ExecuteScheduledReportInput, options: CallOptions) !execute_scheduled_report.ExecuteScheduledReportOutput {
        return execute_scheduled_report.execute(self, allocator, input, options);
    }

    /// Retrieves the configuration and metadata of a specified dashboard, including
    /// its widgets and layout settings.
    pub fn getDashboard(self: *Self, allocator: std.mem.Allocator, input: get_dashboard.GetDashboardInput, options: CallOptions) !get_dashboard.GetDashboardOutput {
        return get_dashboard.execute(self, allocator, input, options);
    }

    /// Retrieves the resource-based policy attached to a dashboard, showing sharing
    /// configurations and permissions.
    pub fn getResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: get_resource_policy.GetResourcePolicyInput, options: CallOptions) !get_resource_policy.GetResourcePolicyOutput {
        return get_resource_policy.execute(self, allocator, input, options);
    }

    /// Retrieves the configuration and metadata of a specified scheduled report.
    pub fn getScheduledReport(self: *Self, allocator: std.mem.Allocator, input: get_scheduled_report.GetScheduledReportInput, options: CallOptions) !get_scheduled_report.GetScheduledReportOutput {
        return get_scheduled_report.execute(self, allocator, input, options);
    }

    /// Returns a list of all dashboards in your account.
    pub fn listDashboards(self: *Self, allocator: std.mem.Allocator, input: list_dashboards.ListDashboardsInput, options: CallOptions) !list_dashboards.ListDashboardsOutput {
        return list_dashboards.execute(self, allocator, input, options);
    }

    /// Returns a list of scheduled reports in your account.
    pub fn listScheduledReports(self: *Self, allocator: std.mem.Allocator, input: list_scheduled_reports.ListScheduledReportsInput, options: CallOptions) !list_scheduled_reports.ListScheduledReportsOutput {
        return list_scheduled_reports.execute(self, allocator, input, options);
    }

    /// Returns a list of all tags associated with a specified dashboard resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Adds or updates tags for a specified dashboard resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes specified tags from a dashboard resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing dashboard's properties, including its name, description,
    /// and widget configurations.
    pub fn updateDashboard(self: *Self, allocator: std.mem.Allocator, input: update_dashboard.UpdateDashboardInput, options: CallOptions) !update_dashboard.UpdateDashboardOutput {
        return update_dashboard.execute(self, allocator, input, options);
    }

    /// Updates an existing scheduled report's properties, including its name,
    /// description, schedule configuration, and widget settings. Only the
    /// parameters included in the request are updated; all other properties remain
    /// unchanged.
    pub fn updateScheduledReport(self: *Self, allocator: std.mem.Allocator, input: update_scheduled_report.UpdateScheduledReportInput, options: CallOptions) !update_scheduled_report.UpdateScheduledReportOutput {
        return update_scheduled_report.execute(self, allocator, input, options);
    }

    pub fn listDashboardsPaginator(self: *Self, params: list_dashboards.ListDashboardsInput) paginator.ListDashboardsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listScheduledReportsPaginator(self: *Self, params: list_scheduled_reports.ListScheduledReportsInput) paginator.ListScheduledReportsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};

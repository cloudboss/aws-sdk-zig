const aws = @import("aws");
const std = @import("std");

const delete_report_definition = @import("delete_report_definition.zig");
const get_report_definition = @import("get_report_definition.zig");
const import_application_usage = @import("import_application_usage.zig");
const list_report_definitions = @import("list_report_definitions.zig");
const put_report_definition = @import("put_report_definition.zig");
const update_report_definition = @import("update_report_definition.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "ApplicationCostProfiler";

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

    /// Deletes the specified report definition in AWS Application Cost Profiler.
    /// This stops the report from being
    /// generated.
    pub fn deleteReportDefinition(self: *Self, allocator: std.mem.Allocator, input: delete_report_definition.DeleteReportDefinitionInput, options: CallOptions) !delete_report_definition.DeleteReportDefinitionOutput {
        return delete_report_definition.execute(self, allocator, input, options);
    }

    /// Retrieves the definition of a report already configured in AWS Application
    /// Cost Profiler.
    pub fn getReportDefinition(self: *Self, allocator: std.mem.Allocator, input: get_report_definition.GetReportDefinitionInput, options: CallOptions) !get_report_definition.GetReportDefinitionOutput {
        return get_report_definition.execute(self, allocator, input, options);
    }

    /// Ingests application usage data from Amazon Simple Storage Service (Amazon
    /// S3).
    ///
    /// The data must already exist in the S3 location. As part of the action, AWS
    /// Application Cost Profiler
    /// copies the object from your S3 bucket to an S3 bucket owned by Amazon for
    /// processing
    /// asynchronously.
    pub fn importApplicationUsage(self: *Self, allocator: std.mem.Allocator, input: import_application_usage.ImportApplicationUsageInput, options: CallOptions) !import_application_usage.ImportApplicationUsageOutput {
        return import_application_usage.execute(self, allocator, input, options);
    }

    /// Retrieves a list of all reports and their configurations for your AWS
    /// account.
    ///
    /// The maximum number of reports is one.
    pub fn listReportDefinitions(self: *Self, allocator: std.mem.Allocator, input: list_report_definitions.ListReportDefinitionsInput, options: CallOptions) !list_report_definitions.ListReportDefinitionsOutput {
        return list_report_definitions.execute(self, allocator, input, options);
    }

    /// Creates the report definition for a report in Application Cost Profiler.
    pub fn putReportDefinition(self: *Self, allocator: std.mem.Allocator, input: put_report_definition.PutReportDefinitionInput, options: CallOptions) !put_report_definition.PutReportDefinitionOutput {
        return put_report_definition.execute(self, allocator, input, options);
    }

    /// Updates existing report in AWS Application Cost Profiler.
    pub fn updateReportDefinition(self: *Self, allocator: std.mem.Allocator, input: update_report_definition.UpdateReportDefinitionInput, options: CallOptions) !update_report_definition.UpdateReportDefinitionOutput {
        return update_report_definition.execute(self, allocator, input, options);
    }

    pub fn listReportDefinitionsPaginator(self: *Self, params: list_report_definitions.ListReportDefinitionsInput) paginator.ListReportDefinitionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};

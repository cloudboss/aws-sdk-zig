const aws = @import("aws");
const std = @import("std");

const create_suite_definition = @import("create_suite_definition.zig");
const delete_suite_definition = @import("delete_suite_definition.zig");
const get_endpoint = @import("get_endpoint.zig");
const get_suite_definition = @import("get_suite_definition.zig");
const get_suite_run = @import("get_suite_run.zig");
const get_suite_run_report = @import("get_suite_run_report.zig");
const list_suite_definitions = @import("list_suite_definitions.zig");
const list_suite_runs = @import("list_suite_runs.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const start_suite_run = @import("start_suite_run.zig");
const stop_suite_run = @import("stop_suite_run.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_suite_definition = @import("update_suite_definition.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "IotDeviceAdvisor";

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

    /// Creates a Device Advisor test suite.
    ///
    /// Requires permission to access the
    /// [CreateSuiteDefinition](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn createSuiteDefinition(self: *Self, allocator: std.mem.Allocator, input: create_suite_definition.CreateSuiteDefinitionInput, options: create_suite_definition.Options) !create_suite_definition.CreateSuiteDefinitionOutput {
        return create_suite_definition.execute(self, allocator, input, options);
    }

    /// Deletes a Device Advisor test suite.
    ///
    /// Requires permission to access the
    /// [DeleteSuiteDefinition](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deleteSuiteDefinition(self: *Self, allocator: std.mem.Allocator, input: delete_suite_definition.DeleteSuiteDefinitionInput, options: delete_suite_definition.Options) !delete_suite_definition.DeleteSuiteDefinitionOutput {
        return delete_suite_definition.execute(self, allocator, input, options);
    }

    /// Gets information about an Device Advisor endpoint.
    pub fn getEndpoint(self: *Self, allocator: std.mem.Allocator, input: get_endpoint.GetEndpointInput, options: get_endpoint.Options) !get_endpoint.GetEndpointOutput {
        return get_endpoint.execute(self, allocator, input, options);
    }

    /// Gets information about a Device Advisor test suite.
    ///
    /// Requires permission to access the
    /// [GetSuiteDefinition](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn getSuiteDefinition(self: *Self, allocator: std.mem.Allocator, input: get_suite_definition.GetSuiteDefinitionInput, options: get_suite_definition.Options) !get_suite_definition.GetSuiteDefinitionOutput {
        return get_suite_definition.execute(self, allocator, input, options);
    }

    /// Gets information about a Device Advisor test suite run.
    ///
    /// Requires permission to access the
    /// [GetSuiteRun](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn getSuiteRun(self: *Self, allocator: std.mem.Allocator, input: get_suite_run.GetSuiteRunInput, options: get_suite_run.Options) !get_suite_run.GetSuiteRunOutput {
        return get_suite_run.execute(self, allocator, input, options);
    }

    /// Gets a report download link for a successful Device Advisor qualifying test
    /// suite run.
    ///
    /// Requires permission to access the
    /// [GetSuiteRunReport](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn getSuiteRunReport(self: *Self, allocator: std.mem.Allocator, input: get_suite_run_report.GetSuiteRunReportInput, options: get_suite_run_report.Options) !get_suite_run_report.GetSuiteRunReportOutput {
        return get_suite_run_report.execute(self, allocator, input, options);
    }

    /// Lists the Device Advisor test suites you have created.
    ///
    /// Requires permission to access the
    /// [ListSuiteDefinitions](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listSuiteDefinitions(self: *Self, allocator: std.mem.Allocator, input: list_suite_definitions.ListSuiteDefinitionsInput, options: list_suite_definitions.Options) !list_suite_definitions.ListSuiteDefinitionsOutput {
        return list_suite_definitions.execute(self, allocator, input, options);
    }

    /// Lists runs of the specified Device Advisor test suite. You can list all runs
    /// of the test
    /// suite, or the runs of a specific version of the test suite.
    ///
    /// Requires permission to access the
    /// [ListSuiteRuns](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listSuiteRuns(self: *Self, allocator: std.mem.Allocator, input: list_suite_runs.ListSuiteRunsInput, options: list_suite_runs.Options) !list_suite_runs.ListSuiteRunsOutput {
        return list_suite_runs.execute(self, allocator, input, options);
    }

    /// Lists the tags attached to an IoT Device Advisor resource.
    ///
    /// Requires permission to access the
    /// [ListTagsForResource](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Starts a Device Advisor test suite run.
    ///
    /// Requires permission to access the
    /// [StartSuiteRun](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn startSuiteRun(self: *Self, allocator: std.mem.Allocator, input: start_suite_run.StartSuiteRunInput, options: start_suite_run.Options) !start_suite_run.StartSuiteRunOutput {
        return start_suite_run.execute(self, allocator, input, options);
    }

    /// Stops a Device Advisor test suite run that is currently running.
    ///
    /// Requires permission to access the
    /// [StopSuiteRun](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn stopSuiteRun(self: *Self, allocator: std.mem.Allocator, input: stop_suite_run.StopSuiteRunInput, options: stop_suite_run.Options) !stop_suite_run.StopSuiteRunOutput {
        return stop_suite_run.execute(self, allocator, input, options);
    }

    /// Adds to and modifies existing tags of an IoT Device Advisor resource.
    ///
    /// Requires permission to access the
    /// [TagResource](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from an IoT Device Advisor resource.
    ///
    /// Requires permission to access the
    /// [UntagResource](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a Device Advisor test suite.
    ///
    /// Requires permission to access the
    /// [UpdateSuiteDefinition](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn updateSuiteDefinition(self: *Self, allocator: std.mem.Allocator, input: update_suite_definition.UpdateSuiteDefinitionInput, options: update_suite_definition.Options) !update_suite_definition.UpdateSuiteDefinitionOutput {
        return update_suite_definition.execute(self, allocator, input, options);
    }

    pub fn listSuiteDefinitionsPaginator(self: *Self, params: list_suite_definitions.ListSuiteDefinitionsInput) paginator.ListSuiteDefinitionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSuiteRunsPaginator(self: *Self, params: list_suite_runs.ListSuiteRunsInput) paginator.ListSuiteRunsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};

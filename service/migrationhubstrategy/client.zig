const aws = @import("aws");
const std = @import("std");

const get_application_component_details = @import("get_application_component_details.zig");
const get_application_component_strategies = @import("get_application_component_strategies.zig");
const get_assessment = @import("get_assessment.zig");
const get_import_file_task = @import("get_import_file_task.zig");
const get_latest_assessment_id = @import("get_latest_assessment_id.zig");
const get_portfolio_preferences = @import("get_portfolio_preferences.zig");
const get_portfolio_summary = @import("get_portfolio_summary.zig");
const get_recommendation_report_details = @import("get_recommendation_report_details.zig");
const get_server_details = @import("get_server_details.zig");
const get_server_strategies = @import("get_server_strategies.zig");
const list_analyzable_servers = @import("list_analyzable_servers.zig");
const list_application_components = @import("list_application_components.zig");
const list_collectors = @import("list_collectors.zig");
const list_import_file_task = @import("list_import_file_task.zig");
const list_servers = @import("list_servers.zig");
const put_portfolio_preferences = @import("put_portfolio_preferences.zig");
const start_assessment = @import("start_assessment.zig");
const start_import_file_task = @import("start_import_file_task.zig");
const start_recommendation_report_generation = @import("start_recommendation_report_generation.zig");
const stop_assessment = @import("stop_assessment.zig");
const update_application_component_config = @import("update_application_component_config.zig");
const update_server_config = @import("update_server_config.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "MigrationHubStrategy";

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

    /// Retrieves details about an application component.
    pub fn getApplicationComponentDetails(self: *Self, allocator: std.mem.Allocator, input: get_application_component_details.GetApplicationComponentDetailsInput, options: CallOptions) !get_application_component_details.GetApplicationComponentDetailsOutput {
        return get_application_component_details.execute(self, allocator, input, options);
    }

    /// Retrieves a list of all the recommended strategies and tools for an
    /// application component
    /// running on a server.
    pub fn getApplicationComponentStrategies(self: *Self, allocator: std.mem.Allocator, input: get_application_component_strategies.GetApplicationComponentStrategiesInput, options: CallOptions) !get_application_component_strategies.GetApplicationComponentStrategiesOutput {
        return get_application_component_strategies.execute(self, allocator, input, options);
    }

    /// Retrieves the status of an on-going assessment.
    pub fn getAssessment(self: *Self, allocator: std.mem.Allocator, input: get_assessment.GetAssessmentInput, options: CallOptions) !get_assessment.GetAssessmentOutput {
        return get_assessment.execute(self, allocator, input, options);
    }

    /// Retrieves the details about a specific import task.
    pub fn getImportFileTask(self: *Self, allocator: std.mem.Allocator, input: get_import_file_task.GetImportFileTaskInput, options: CallOptions) !get_import_file_task.GetImportFileTaskOutput {
        return get_import_file_task.execute(self, allocator, input, options);
    }

    /// Retrieve the latest ID of a specific assessment task.
    pub fn getLatestAssessmentId(self: *Self, allocator: std.mem.Allocator, input: get_latest_assessment_id.GetLatestAssessmentIdInput, options: CallOptions) !get_latest_assessment_id.GetLatestAssessmentIdOutput {
        return get_latest_assessment_id.execute(self, allocator, input, options);
    }

    /// Retrieves your migration and modernization preferences.
    pub fn getPortfolioPreferences(self: *Self, allocator: std.mem.Allocator, input: get_portfolio_preferences.GetPortfolioPreferencesInput, options: CallOptions) !get_portfolio_preferences.GetPortfolioPreferencesOutput {
        return get_portfolio_preferences.execute(self, allocator, input, options);
    }

    /// Retrieves overall summary including the number of servers to rehost and the
    /// overall
    /// number of anti-patterns.
    pub fn getPortfolioSummary(self: *Self, allocator: std.mem.Allocator, input: get_portfolio_summary.GetPortfolioSummaryInput, options: CallOptions) !get_portfolio_summary.GetPortfolioSummaryOutput {
        return get_portfolio_summary.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about the specified recommendation report.
    pub fn getRecommendationReportDetails(self: *Self, allocator: std.mem.Allocator, input: get_recommendation_report_details.GetRecommendationReportDetailsInput, options: CallOptions) !get_recommendation_report_details.GetRecommendationReportDetailsOutput {
        return get_recommendation_report_details.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specified server.
    pub fn getServerDetails(self: *Self, allocator: std.mem.Allocator, input: get_server_details.GetServerDetailsInput, options: CallOptions) !get_server_details.GetServerDetailsOutput {
        return get_server_details.execute(self, allocator, input, options);
    }

    /// Retrieves recommended strategies and tools for the specified server.
    pub fn getServerStrategies(self: *Self, allocator: std.mem.Allocator, input: get_server_strategies.GetServerStrategiesInput, options: CallOptions) !get_server_strategies.GetServerStrategiesOutput {
        return get_server_strategies.execute(self, allocator, input, options);
    }

    /// Retrieves a list of all the servers fetched from customer vCenter using
    /// Strategy Recommendation Collector.
    pub fn listAnalyzableServers(self: *Self, allocator: std.mem.Allocator, input: list_analyzable_servers.ListAnalyzableServersInput, options: CallOptions) !list_analyzable_servers.ListAnalyzableServersOutput {
        return list_analyzable_servers.execute(self, allocator, input, options);
    }

    /// Retrieves a list of all the application components (processes).
    pub fn listApplicationComponents(self: *Self, allocator: std.mem.Allocator, input: list_application_components.ListApplicationComponentsInput, options: CallOptions) !list_application_components.ListApplicationComponentsOutput {
        return list_application_components.execute(self, allocator, input, options);
    }

    /// Retrieves a list of all the installed collectors.
    pub fn listCollectors(self: *Self, allocator: std.mem.Allocator, input: list_collectors.ListCollectorsInput, options: CallOptions) !list_collectors.ListCollectorsOutput {
        return list_collectors.execute(self, allocator, input, options);
    }

    /// Retrieves a list of all the imports performed.
    pub fn listImportFileTask(self: *Self, allocator: std.mem.Allocator, input: list_import_file_task.ListImportFileTaskInput, options: CallOptions) !list_import_file_task.ListImportFileTaskOutput {
        return list_import_file_task.execute(self, allocator, input, options);
    }

    /// Returns a list of all the servers.
    pub fn listServers(self: *Self, allocator: std.mem.Allocator, input: list_servers.ListServersInput, options: CallOptions) !list_servers.ListServersOutput {
        return list_servers.execute(self, allocator, input, options);
    }

    /// Saves the specified migration and modernization preferences.
    pub fn putPortfolioPreferences(self: *Self, allocator: std.mem.Allocator, input: put_portfolio_preferences.PutPortfolioPreferencesInput, options: CallOptions) !put_portfolio_preferences.PutPortfolioPreferencesOutput {
        return put_portfolio_preferences.execute(self, allocator, input, options);
    }

    /// Starts the assessment of an on-premises environment.
    pub fn startAssessment(self: *Self, allocator: std.mem.Allocator, input: start_assessment.StartAssessmentInput, options: CallOptions) !start_assessment.StartAssessmentOutput {
        return start_assessment.execute(self, allocator, input, options);
    }

    /// Starts a file import.
    pub fn startImportFileTask(self: *Self, allocator: std.mem.Allocator, input: start_import_file_task.StartImportFileTaskInput, options: CallOptions) !start_import_file_task.StartImportFileTaskOutput {
        return start_import_file_task.execute(self, allocator, input, options);
    }

    /// Starts generating a recommendation report.
    pub fn startRecommendationReportGeneration(self: *Self, allocator: std.mem.Allocator, input: start_recommendation_report_generation.StartRecommendationReportGenerationInput, options: CallOptions) !start_recommendation_report_generation.StartRecommendationReportGenerationOutput {
        return start_recommendation_report_generation.execute(self, allocator, input, options);
    }

    /// Stops the assessment of an on-premises environment.
    pub fn stopAssessment(self: *Self, allocator: std.mem.Allocator, input: stop_assessment.StopAssessmentInput, options: CallOptions) !stop_assessment.StopAssessmentOutput {
        return stop_assessment.execute(self, allocator, input, options);
    }

    /// Updates the configuration of an application component.
    pub fn updateApplicationComponentConfig(self: *Self, allocator: std.mem.Allocator, input: update_application_component_config.UpdateApplicationComponentConfigInput, options: CallOptions) !update_application_component_config.UpdateApplicationComponentConfigOutput {
        return update_application_component_config.execute(self, allocator, input, options);
    }

    /// Updates the configuration of the specified server.
    pub fn updateServerConfig(self: *Self, allocator: std.mem.Allocator, input: update_server_config.UpdateServerConfigInput, options: CallOptions) !update_server_config.UpdateServerConfigOutput {
        return update_server_config.execute(self, allocator, input, options);
    }

    pub fn getServerDetailsPaginator(self: *Self, params: get_server_details.GetServerDetailsInput) paginator.GetServerDetailsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAnalyzableServersPaginator(self: *Self, params: list_analyzable_servers.ListAnalyzableServersInput) paginator.ListAnalyzableServersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listApplicationComponentsPaginator(self: *Self, params: list_application_components.ListApplicationComponentsInput) paginator.ListApplicationComponentsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCollectorsPaginator(self: *Self, params: list_collectors.ListCollectorsInput) paginator.ListCollectorsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listImportFileTaskPaginator(self: *Self, params: list_import_file_task.ListImportFileTaskInput) paginator.ListImportFileTaskPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listServersPaginator(self: *Self, params: list_servers.ListServersInput) paginator.ListServersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};

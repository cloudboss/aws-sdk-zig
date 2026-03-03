const aws = @import("aws");
const std = @import("std");

const create_performance_analysis_report = @import("create_performance_analysis_report.zig");
const delete_performance_analysis_report = @import("delete_performance_analysis_report.zig");
const describe_dimension_keys = @import("describe_dimension_keys.zig");
const get_dimension_key_details = @import("get_dimension_key_details.zig");
const get_performance_analysis_report = @import("get_performance_analysis_report.zig");
const get_resource_metadata = @import("get_resource_metadata.zig");
const get_resource_metrics = @import("get_resource_metrics.zig");
const list_available_resource_dimensions = @import("list_available_resource_dimensions.zig");
const list_available_resource_metrics = @import("list_available_resource_metrics.zig");
const list_performance_analysis_reports = @import("list_performance_analysis_reports.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "PI";

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

    /// Creates a new performance analysis report for a specific time period for the
    /// DB instance.
    pub fn createPerformanceAnalysisReport(self: *Self, allocator: std.mem.Allocator, input: create_performance_analysis_report.CreatePerformanceAnalysisReportInput, options: CallOptions) !create_performance_analysis_report.CreatePerformanceAnalysisReportOutput {
        return create_performance_analysis_report.execute(self, allocator, input, options);
    }

    /// Deletes a performance analysis report.
    pub fn deletePerformanceAnalysisReport(self: *Self, allocator: std.mem.Allocator, input: delete_performance_analysis_report.DeletePerformanceAnalysisReportInput, options: CallOptions) !delete_performance_analysis_report.DeletePerformanceAnalysisReportOutput {
        return delete_performance_analysis_report.execute(self, allocator, input, options);
    }

    /// For a specific time period, retrieve the top `N` dimension keys for a
    /// metric.
    ///
    /// Each response element returns a maximum of 500 bytes. For larger elements,
    /// such as SQL statements,
    /// only the first 500 bytes are returned.
    pub fn describeDimensionKeys(self: *Self, allocator: std.mem.Allocator, input: describe_dimension_keys.DescribeDimensionKeysInput, options: CallOptions) !describe_dimension_keys.DescribeDimensionKeysOutput {
        return describe_dimension_keys.execute(self, allocator, input, options);
    }

    /// Get the attributes of the specified dimension group for a DB instance or
    /// data source. For example, if you specify a SQL ID,
    /// `GetDimensionKeyDetails` retrieves the full text of the dimension
    /// `db.sql.statement` associated with this ID.
    /// This operation is useful because `GetResourceMetrics` and
    /// `DescribeDimensionKeys` don't support retrieval of large
    /// SQL statement text, lock snapshots, and execution plans.
    pub fn getDimensionKeyDetails(self: *Self, allocator: std.mem.Allocator, input: get_dimension_key_details.GetDimensionKeyDetailsInput, options: CallOptions) !get_dimension_key_details.GetDimensionKeyDetailsOutput {
        return get_dimension_key_details.execute(self, allocator, input, options);
    }

    /// Retrieves the report including the report ID, status, time details, and the
    /// insights
    /// with recommendations. The report status can be `RUNNING`,
    /// `SUCCEEDED`, or `FAILED`. The insights include the
    /// `description` and `recommendation` fields.
    pub fn getPerformanceAnalysisReport(self: *Self, allocator: std.mem.Allocator, input: get_performance_analysis_report.GetPerformanceAnalysisReportInput, options: CallOptions) !get_performance_analysis_report.GetPerformanceAnalysisReportOutput {
        return get_performance_analysis_report.execute(self, allocator, input, options);
    }

    /// Retrieve the metadata for different features. For example, the metadata
    /// might indicate
    /// that a feature is turned on or off on a specific DB instance.
    pub fn getResourceMetadata(self: *Self, allocator: std.mem.Allocator, input: get_resource_metadata.GetResourceMetadataInput, options: CallOptions) !get_resource_metadata.GetResourceMetadataOutput {
        return get_resource_metadata.execute(self, allocator, input, options);
    }

    /// Retrieve Performance Insights metrics for a set of data sources over a time
    /// period. You can provide
    /// specific dimension groups and dimensions, and provide filtering criteria for
    /// each group. You must specify an aggregate function for
    /// each metric.
    ///
    /// Each response element returns a maximum of 500 bytes. For larger elements,
    /// such as SQL statements,
    /// only the first 500 bytes are returned.
    pub fn getResourceMetrics(self: *Self, allocator: std.mem.Allocator, input: get_resource_metrics.GetResourceMetricsInput, options: CallOptions) !get_resource_metrics.GetResourceMetricsOutput {
        return get_resource_metrics.execute(self, allocator, input, options);
    }

    /// Retrieve the dimensions that can be queried for each specified metric type
    /// on a specified DB instance.
    pub fn listAvailableResourceDimensions(self: *Self, allocator: std.mem.Allocator, input: list_available_resource_dimensions.ListAvailableResourceDimensionsInput, options: CallOptions) !list_available_resource_dimensions.ListAvailableResourceDimensionsOutput {
        return list_available_resource_dimensions.execute(self, allocator, input, options);
    }

    /// Retrieve metrics of the specified types that can be queried for a specified
    /// DB instance.
    pub fn listAvailableResourceMetrics(self: *Self, allocator: std.mem.Allocator, input: list_available_resource_metrics.ListAvailableResourceMetricsInput, options: CallOptions) !list_available_resource_metrics.ListAvailableResourceMetricsOutput {
        return list_available_resource_metrics.execute(self, allocator, input, options);
    }

    /// Lists all the analysis reports created for the DB instance. The reports are
    /// sorted based on the start time of each report.
    pub fn listPerformanceAnalysisReports(self: *Self, allocator: std.mem.Allocator, input: list_performance_analysis_reports.ListPerformanceAnalysisReportsInput, options: CallOptions) !list_performance_analysis_reports.ListPerformanceAnalysisReportsOutput {
        return list_performance_analysis_reports.execute(self, allocator, input, options);
    }

    /// Retrieves all the metadata tags associated with Amazon RDS Performance
    /// Insights resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Adds metadata tags to the Amazon RDS Performance Insights resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Deletes the metadata tags from the Amazon RDS Performance Insights resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    pub fn describeDimensionKeysPaginator(self: *Self, params: describe_dimension_keys.DescribeDimensionKeysInput) paginator.DescribeDimensionKeysPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getResourceMetricsPaginator(self: *Self, params: get_resource_metrics.GetResourceMetricsInput) paginator.GetResourceMetricsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAvailableResourceDimensionsPaginator(self: *Self, params: list_available_resource_dimensions.ListAvailableResourceDimensionsInput) paginator.ListAvailableResourceDimensionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAvailableResourceMetricsPaginator(self: *Self, params: list_available_resource_metrics.ListAvailableResourceMetricsInput) paginator.ListAvailableResourceMetricsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPerformanceAnalysisReportsPaginator(self: *Self, params: list_performance_analysis_reports.ListPerformanceAnalysisReportsInput) paginator.ListPerformanceAnalysisReportsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};

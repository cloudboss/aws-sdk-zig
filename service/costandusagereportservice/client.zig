const aws = @import("aws");
const std = @import("std");

const delete_report_definition = @import("delete_report_definition.zig");
const describe_report_definitions = @import("describe_report_definitions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const modify_report_definition = @import("modify_report_definition.zig");
const put_report_definition = @import("put_report_definition.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Cost and Usage Report Service";

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

    /// Deletes the specified report. Any tags associated with the report are also
    /// deleted.
    pub fn deleteReportDefinition(self: *Self, allocator: std.mem.Allocator, input: delete_report_definition.DeleteReportDefinitionInput, options: CallOptions) !delete_report_definition.DeleteReportDefinitionOutput {
        return delete_report_definition.execute(self, allocator, input, options);
    }

    /// Lists the Amazon Web Services Cost and Usage Report available to this
    /// account.
    pub fn describeReportDefinitions(self: *Self, allocator: std.mem.Allocator, input: describe_report_definitions.DescribeReportDefinitionsInput, options: CallOptions) !describe_report_definitions.DescribeReportDefinitionsOutput {
        return describe_report_definitions.execute(self, allocator, input, options);
    }

    /// Lists the tags associated with the specified report definition.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Allows you to programmatically update your report preferences.
    pub fn modifyReportDefinition(self: *Self, allocator: std.mem.Allocator, input: modify_report_definition.ModifyReportDefinitionInput, options: CallOptions) !modify_report_definition.ModifyReportDefinitionOutput {
        return modify_report_definition.execute(self, allocator, input, options);
    }

    /// Creates a new report using the description that you provide.
    pub fn putReportDefinition(self: *Self, allocator: std.mem.Allocator, input: put_report_definition.PutReportDefinitionInput, options: CallOptions) !put_report_definition.PutReportDefinitionOutput {
        return put_report_definition.execute(self, allocator, input, options);
    }

    /// Associates a set of tags with a report definition.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Disassociates a set of tags from a report definition.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    pub fn describeReportDefinitionsPaginator(self: *Self, params: describe_report_definitions.DescribeReportDefinitionsInput) paginator.DescribeReportDefinitionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};

const aws = @import("aws");
const std = @import("std");

const get_data_automation_status = @import("get_data_automation_status.zig");
const invoke_data_automation = @import("invoke_data_automation.zig");
const invoke_data_automation_async = @import("invoke_data_automation_async.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Bedrock Data Automation Runtime";

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

    /// API used to get data automation status.
    pub fn getDataAutomationStatus(self: *Self, allocator: std.mem.Allocator, input: get_data_automation_status.GetDataAutomationStatusInput, options: get_data_automation_status.Options) !get_data_automation_status.GetDataAutomationStatusOutput {
        return get_data_automation_status.execute(self, allocator, input, options);
    }

    /// Sync API: Invoke data automation.
    pub fn invokeDataAutomation(self: *Self, allocator: std.mem.Allocator, input: invoke_data_automation.InvokeDataAutomationInput, options: invoke_data_automation.Options) !invoke_data_automation.InvokeDataAutomationOutput {
        return invoke_data_automation.execute(self, allocator, input, options);
    }

    /// Async API: Invoke data automation.
    pub fn invokeDataAutomationAsync(self: *Self, allocator: std.mem.Allocator, input: invoke_data_automation_async.InvokeDataAutomationAsyncInput, options: invoke_data_automation_async.Options) !invoke_data_automation_async.InvokeDataAutomationAsyncOutput {
        return invoke_data_automation_async.execute(self, allocator, input, options);
    }

    /// List tags for an Amazon Bedrock Data Automation resource
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Tag an Amazon Bedrock Data Automation resource
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Untag an Amazon Bedrock Data Automation resource
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }
};

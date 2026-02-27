const aws = @import("aws");
const std = @import("std");

const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_deployment_parameter = @import("put_deployment_parameter.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Marketplace Deployment";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Lists all tags that have been added to a deployment parameter resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Creates or updates a deployment parameter and is targeted by `catalog` and
    /// `agreementId`.
    pub fn putDeploymentParameter(self: *Self, allocator: std.mem.Allocator, input: put_deployment_parameter.PutDeploymentParameterInput, options: put_deployment_parameter.Options) !put_deployment_parameter.PutDeploymentParameterOutput {
        return put_deployment_parameter.execute(self, allocator, input, options);
    }

    /// Tags a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag or list of tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }
};

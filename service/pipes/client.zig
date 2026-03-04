const aws = @import("aws");
const std = @import("std");

const create_pipe = @import("create_pipe.zig");
const delete_pipe = @import("delete_pipe.zig");
const describe_pipe = @import("describe_pipe.zig");
const list_pipes = @import("list_pipes.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const start_pipe = @import("start_pipe.zig");
const stop_pipe = @import("stop_pipe.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_pipe = @import("update_pipe.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Pipes";

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

    /// Create a pipe. Amazon EventBridge Pipes connect event sources to targets and
    /// reduces
    /// the need for specialized knowledge and integration code.
    pub fn createPipe(self: *Self, allocator: std.mem.Allocator, input: create_pipe.CreatePipeInput, options: CallOptions) !create_pipe.CreatePipeOutput {
        return create_pipe.execute(self, allocator, input, options);
    }

    /// Delete an existing pipe. For more information about pipes, see [Amazon
    /// EventBridge
    /// Pipes](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-pipes.html) in the Amazon EventBridge User Guide.
    pub fn deletePipe(self: *Self, allocator: std.mem.Allocator, input: delete_pipe.DeletePipeInput, options: CallOptions) !delete_pipe.DeletePipeOutput {
        return delete_pipe.execute(self, allocator, input, options);
    }

    /// Get the information about an existing pipe. For more information about
    /// pipes, see [Amazon EventBridge
    /// Pipes](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-pipes.html) in the Amazon EventBridge User Guide.
    pub fn describePipe(self: *Self, allocator: std.mem.Allocator, input: describe_pipe.DescribePipeInput, options: CallOptions) !describe_pipe.DescribePipeOutput {
        return describe_pipe.execute(self, allocator, input, options);
    }

    /// Get the pipes associated with this account. For more information about
    /// pipes, see [Amazon EventBridge
    /// Pipes](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-pipes.html) in the Amazon EventBridge User Guide.
    pub fn listPipes(self: *Self, allocator: std.mem.Allocator, input: list_pipes.ListPipesInput, options: CallOptions) !list_pipes.ListPipesOutput {
        return list_pipes.execute(self, allocator, input, options);
    }

    /// Displays the tags associated with a pipe.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Start an existing pipe.
    pub fn startPipe(self: *Self, allocator: std.mem.Allocator, input: start_pipe.StartPipeInput, options: CallOptions) !start_pipe.StartPipeOutput {
        return start_pipe.execute(self, allocator, input, options);
    }

    /// Stop an existing pipe.
    pub fn stopPipe(self: *Self, allocator: std.mem.Allocator, input: stop_pipe.StopPipeInput, options: CallOptions) !stop_pipe.StopPipeOutput {
        return stop_pipe.execute(self, allocator, input, options);
    }

    /// Assigns one or more tags (key-value pairs) to the specified pipe. Tags can
    /// help you
    /// organize and categorize your resources. You can also use them to scope user
    /// permissions by
    /// granting a user permission to access or change only resources with certain
    /// tag
    /// values.
    ///
    /// Tags don't have any semantic meaning to Amazon Web Services and are
    /// interpreted strictly
    /// as strings of characters.
    ///
    /// You can use the `TagResource` action with a pipe that already has tags. If
    /// you specify a new tag key, this tag is appended to the list of tags
    /// associated with the
    /// pipe. If you specify a tag key that is already associated with the pipe, the
    /// new tag value
    /// that you specify replaces the previous value for that tag.
    ///
    /// You can associate as many as 50 tags with a pipe.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from the specified pipes.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Update an existing pipe. When you call `UpdatePipe`, EventBridge only the
    /// updates fields you have specified in the request; the rest remain unchanged.
    /// The exception
    /// to this is if you modify any Amazon Web Services-service specific fields in
    /// the
    /// `SourceParameters`, `EnrichmentParameters`, or
    /// `TargetParameters` objects. For example,
    /// `DynamoDBStreamParameters` or `EventBridgeEventBusParameters`.
    /// EventBridge updates the fields in these objects atomically as one and
    /// overrides existing
    /// values. This is by design, and means that if you don't specify an optional
    /// field in one of
    /// these `Parameters` objects, EventBridge sets that field to its
    /// system-default
    /// value during the update.
    ///
    /// For more information about pipes, see [
    /// Amazon EventBridge
    /// Pipes](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-pipes.html) in the Amazon EventBridge User Guide.
    pub fn updatePipe(self: *Self, allocator: std.mem.Allocator, input: update_pipe.UpdatePipeInput, options: CallOptions) !update_pipe.UpdatePipeOutput {
        return update_pipe.execute(self, allocator, input, options);
    }

    pub fn listPipesPaginator(self: *Self, params: list_pipes.ListPipesInput) paginator.ListPipesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};

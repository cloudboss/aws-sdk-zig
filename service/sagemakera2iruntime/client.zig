const aws = @import("aws");
const std = @import("std");

const delete_human_loop = @import("delete_human_loop.zig");
const describe_human_loop = @import("describe_human_loop.zig");
const list_human_loops = @import("list_human_loops.zig");
const start_human_loop = @import("start_human_loop.zig");
const stop_human_loop = @import("stop_human_loop.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "SageMaker A2I Runtime";

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

    /// Deletes the specified human loop for a flow definition.
    ///
    /// If the human loop was deleted, this operation will return a
    /// `ResourceNotFoundException`.
    pub fn deleteHumanLoop(self: *Self, allocator: std.mem.Allocator, input: delete_human_loop.DeleteHumanLoopInput, options: delete_human_loop.Options) !delete_human_loop.DeleteHumanLoopOutput {
        return delete_human_loop.execute(self, allocator, input, options);
    }

    /// Returns information about the specified human loop. If the human loop was
    /// deleted, this
    /// operation will return a `ResourceNotFoundException` error.
    pub fn describeHumanLoop(self: *Self, allocator: std.mem.Allocator, input: describe_human_loop.DescribeHumanLoopInput, options: describe_human_loop.Options) !describe_human_loop.DescribeHumanLoopOutput {
        return describe_human_loop.execute(self, allocator, input, options);
    }

    /// Returns information about human loops, given the specified parameters. If a
    /// human loop was deleted, it will not be included.
    pub fn listHumanLoops(self: *Self, allocator: std.mem.Allocator, input: list_human_loops.ListHumanLoopsInput, options: list_human_loops.Options) !list_human_loops.ListHumanLoopsOutput {
        return list_human_loops.execute(self, allocator, input, options);
    }

    /// Starts a human loop, provided that at least one activation condition is met.
    pub fn startHumanLoop(self: *Self, allocator: std.mem.Allocator, input: start_human_loop.StartHumanLoopInput, options: start_human_loop.Options) !start_human_loop.StartHumanLoopOutput {
        return start_human_loop.execute(self, allocator, input, options);
    }

    /// Stops the specified human loop.
    pub fn stopHumanLoop(self: *Self, allocator: std.mem.Allocator, input: stop_human_loop.StopHumanLoopInput, options: stop_human_loop.Options) !stop_human_loop.StopHumanLoopOutput {
        return stop_human_loop.execute(self, allocator, input, options);
    }

    pub fn listHumanLoopsPaginator(self: *Self, params: list_human_loops.ListHumanLoopsInput) paginator.ListHumanLoopsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};

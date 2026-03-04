const aws = @import("aws");
const std = @import("std");

const CallOptions = @import("call_options.zig").CallOptions;
const Client = @import("client.zig").Client;

const describe_objects = @import("describe_objects.zig");
const list_pipelines = @import("list_pipelines.zig");
const query_objects = @import("query_objects.zig");

pub const DescribeObjectsPaginator = struct {
    client: *Client,
    params: describe_objects.DescribeObjectsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !describe_objects.DescribeObjectsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_objects.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const ListPipelinesPaginator = struct {
    client: *Client,
    params: list_pipelines.ListPipelinesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_pipelines.ListPipelinesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_pipelines.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const QueryObjectsPaginator = struct {
    client: *Client,
    params: query_objects.QueryObjectsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !query_objects.QueryObjectsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try query_objects.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

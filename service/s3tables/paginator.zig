const aws = @import("aws");
const std = @import("std");

const CallOptions = @import("call_options.zig").CallOptions;
const Client = @import("client.zig").Client;

const list_namespaces = @import("list_namespaces.zig");
const list_table_buckets = @import("list_table_buckets.zig");
const list_tables = @import("list_tables.zig");

pub const ListNamespacesPaginator = struct {
    client: *Client,
    params: list_namespaces.ListNamespacesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_namespaces.ListNamespacesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.continuation_token = self.next_token;

        const output = try list_namespaces.execute(self.client, allocator, self.params, options);

        if (output.continuation_token) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListTableBucketsPaginator = struct {
    client: *Client,
    params: list_table_buckets.ListTableBucketsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_table_buckets.ListTableBucketsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.continuation_token = self.next_token;

        const output = try list_table_buckets.execute(self.client, allocator, self.params, options);

        if (output.continuation_token) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListTablesPaginator = struct {
    client: *Client,
    params: list_tables.ListTablesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_tables.ListTablesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.continuation_token = self.next_token;

        const output = try list_tables.execute(self.client, allocator, self.params, options);

        if (output.continuation_token) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

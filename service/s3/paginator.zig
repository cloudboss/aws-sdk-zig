const aws = @import("aws");
const std = @import("std");

const CallOptions = @import("call_options.zig").CallOptions;
const Client = @import("client.zig").Client;

const list_buckets = @import("list_buckets.zig");
const list_directory_buckets = @import("list_directory_buckets.zig");
const list_object_annotations = @import("list_object_annotations.zig");
const list_objects_v2 = @import("list_objects_v2.zig");
const list_parts = @import("list_parts.zig");

pub const ListBucketsPaginator = struct {
    client: *Client,
    params: list_buckets.ListBucketsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_buckets.ListBucketsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.continuation_token = self.next_token;

        const output = try list_buckets.execute(self.client, allocator, self.params, options);

        const next_token: ?[]const u8 = output.continuation_token;
        const owned_token = if (next_token) |token|
            if (token.len > 0) try self.client.allocator.dupe(u8, token) else null
        else
            null;
        if (self.next_token) |old| {
            self.client.allocator.free(old);
        }
        self.next_token = owned_token;
        self.done = self.next_token == null;

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const ListDirectoryBucketsPaginator = struct {
    client: *Client,
    params: list_directory_buckets.ListDirectoryBucketsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_directory_buckets.ListDirectoryBucketsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.continuation_token = self.next_token;

        const output = try list_directory_buckets.execute(self.client, allocator, self.params, options);

        const next_token: ?[]const u8 = output.continuation_token;
        const owned_token = if (next_token) |token|
            if (token.len > 0) try self.client.allocator.dupe(u8, token) else null
        else
            null;
        if (self.next_token) |old| {
            self.client.allocator.free(old);
        }
        self.next_token = owned_token;
        self.done = self.next_token == null;

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const ListObjectAnnotationsPaginator = struct {
    client: *Client,
    params: list_object_annotations.ListObjectAnnotationsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_object_annotations.ListObjectAnnotationsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.continuation_token = self.next_token;

        const output = try list_object_annotations.execute(self.client, allocator, self.params, options);

        const next_token: ?[]const u8 = output.next_continuation_token;
        const owned_token = if (next_token) |token|
            if (token.len > 0) try self.client.allocator.dupe(u8, token) else null
        else
            null;
        if (self.next_token) |old| {
            self.client.allocator.free(old);
        }
        self.next_token = owned_token;
        self.done = self.next_token == null;

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const ListObjectsV2Paginator = struct {
    client: *Client,
    params: list_objects_v2.ListObjectsV2Input,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_objects_v2.ListObjectsV2Output {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.continuation_token = self.next_token;

        const output = try list_objects_v2.execute(self.client, allocator, self.params, options);

        const next_token: ?[]const u8 = output.next_continuation_token;
        const owned_token = if (next_token) |token|
            if (token.len > 0) try self.client.allocator.dupe(u8, token) else null
        else
            null;
        if (self.next_token) |old| {
            self.client.allocator.free(old);
        }
        self.next_token = owned_token;
        self.done = self.next_token == null;

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const ListPartsPaginator = struct {
    client: *Client,
    params: list_parts.ListPartsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_parts.ListPartsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.part_number_marker = self.next_token;

        const output = try list_parts.execute(self.client, allocator, self.params, options);

        const next_token: ?[]const u8 = output.next_part_number_marker;
        const owned_token = if (next_token) |token|
            if (token.len > 0) try self.client.allocator.dupe(u8, token) else null
        else
            null;
        if (self.next_token) |old| {
            self.client.allocator.free(old);
        }
        self.next_token = owned_token;
        self.done = self.next_token == null;

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

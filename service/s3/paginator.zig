const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const list_buckets = @import("list_buckets.zig");
const list_directory_buckets = @import("list_directory_buckets.zig");
const list_objects_v2 = @import("list_objects_v2.zig");
const list_parts = @import("list_parts.zig");

pub const ListBucketsPaginator = struct {
    client: *Client,
    params: list_buckets.ListBucketsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: list_buckets.Options) !list_buckets.ListBucketsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.continuation_token = self.next_token;

        const output = try list_buckets.execute(self.client, allocator, self.params, options);

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

pub const ListDirectoryBucketsPaginator = struct {
    client: *Client,
    params: list_directory_buckets.ListDirectoryBucketsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: list_directory_buckets.Options) !list_directory_buckets.ListDirectoryBucketsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.continuation_token = self.next_token;

        const output = try list_directory_buckets.execute(self.client, allocator, self.params, options);

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

pub const ListObjectsV2Paginator = struct {
    client: *Client,
    params: list_objects_v2.ListObjectsV2Input,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: list_objects_v2.Options) !list_objects_v2.ListObjectsV2Output {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.continuation_token = self.next_token;

        const output = try list_objects_v2.execute(self.client, allocator, self.params, options);

        if (output.next_continuation_token) |token| {
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

pub const ListPartsPaginator = struct {
    client: *Client,
    params: list_parts.ListPartsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: list_parts.Options) !list_parts.ListPartsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.part_number_marker = self.next_token;

        const output = try list_parts.execute(self.client, allocator, self.params, options);

        if (output.next_part_number_marker) |token| {
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

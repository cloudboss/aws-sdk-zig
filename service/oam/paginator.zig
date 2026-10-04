const aws = @import("aws");
const std = @import("std");

const CallOptions = @import("call_options.zig").CallOptions;
const Client = @import("client.zig").Client;

const list_attached_links = @import("list_attached_links.zig");
const list_links = @import("list_links.zig");
const list_sinks = @import("list_sinks.zig");

pub const ListAttachedLinksPaginator = struct {
    client: *Client,
    params: list_attached_links.ListAttachedLinksInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_attached_links.ListAttachedLinksOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try list_attached_links.execute(self.client, allocator, self.params, options);

        const next_token: ?[]const u8 = output.next_token;
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

pub const ListLinksPaginator = struct {
    client: *Client,
    params: list_links.ListLinksInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_links.ListLinksOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try list_links.execute(self.client, allocator, self.params, options);

        const next_token: ?[]const u8 = output.next_token;
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

pub const ListSinksPaginator = struct {
    client: *Client,
    params: list_sinks.ListSinksInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_sinks.ListSinksOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try list_sinks.execute(self.client, allocator, self.params, options);

        const next_token: ?[]const u8 = output.next_token;
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

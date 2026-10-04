const aws = @import("aws");
const std = @import("std");

const CallOptions = @import("call_options.zig").CallOptions;
const Client = @import("client.zig").Client;

const list_library_items = @import("list_library_items.zig");
const list_q_apps = @import("list_q_apps.zig");

pub const ListLibraryItemsPaginator = struct {
    client: *Client,
    params: list_library_items.ListLibraryItemsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_library_items.ListLibraryItemsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try list_library_items.execute(self.client, allocator, self.params, options);

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

pub const ListQAppsPaginator = struct {
    client: *Client,
    params: list_q_apps.ListQAppsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_q_apps.ListQAppsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try list_q_apps.execute(self.client, allocator, self.params, options);

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

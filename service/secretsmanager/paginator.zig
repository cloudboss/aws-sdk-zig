const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const batch_get_secret_value = @import("batch_get_secret_value.zig");
const list_secret_version_ids = @import("list_secret_version_ids.zig");
const list_secrets = @import("list_secrets.zig");

pub const BatchGetSecretValuePaginator = struct {
    client: *Client,
    params: batch_get_secret_value.BatchGetSecretValueInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: batch_get_secret_value.Options) !batch_get_secret_value.BatchGetSecretValueOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try batch_get_secret_value.execute(self.client, self.params, options);


        if (output.next_token) |token| {
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

pub const ListSecretVersionIdsPaginator = struct {
    client: *Client,
    params: list_secret_version_ids.ListSecretVersionIdsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_secret_version_ids.Options) !list_secret_version_ids.ListSecretVersionIdsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try list_secret_version_ids.execute(self.client, self.params, options);


        if (output.next_token) |token| {
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

pub const ListSecretsPaginator = struct {
    client: *Client,
    params: list_secrets.ListSecretsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_secrets.Options) !list_secrets.ListSecretsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try list_secrets.execute(self.client, self.params, options);


        if (output.next_token) |token| {
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

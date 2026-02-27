const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const list_configuration_managers = @import("list_configuration_managers.zig");
const list_configurations = @import("list_configurations.zig");

pub const ListConfigurationManagersPaginator = struct {
    client: *Client,
    params: list_configuration_managers.ListConfigurationManagersInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: list_configuration_managers.Options) !list_configuration_managers.ListConfigurationManagersOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.starting_token = self.next_token;

        const output = try list_configuration_managers.execute(self.client, allocator, self.params, options);

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

pub const ListConfigurationsPaginator = struct {
    client: *Client,
    params: list_configurations.ListConfigurationsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: list_configurations.Options) !list_configurations.ListConfigurationsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.starting_token = self.next_token;

        const output = try list_configurations.execute(self.client, allocator, self.params, options);

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

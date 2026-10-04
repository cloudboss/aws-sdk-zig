const aws = @import("aws");
const std = @import("std");

const CallOptions = @import("call_options.zig").CallOptions;
const Client = @import("client.zig").Client;

const list_domains = @import("list_domains.zig");
const list_operations = @import("list_operations.zig");
const list_prices = @import("list_prices.zig");
const view_billing = @import("view_billing.zig");

pub const ListDomainsPaginator = struct {
    client: *Client,
    params: list_domains.ListDomainsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_domains.ListDomainsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_domains.execute(self.client, allocator, self.params, options);

        const next_token: ?[]const u8 = output.next_page_marker;
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

pub const ListOperationsPaginator = struct {
    client: *Client,
    params: list_operations.ListOperationsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_operations.ListOperationsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_operations.execute(self.client, allocator, self.params, options);

        const next_token: ?[]const u8 = output.next_page_marker;
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

pub const ListPricesPaginator = struct {
    client: *Client,
    params: list_prices.ListPricesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_prices.ListPricesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_prices.execute(self.client, allocator, self.params, options);

        const next_token: ?[]const u8 = output.next_page_marker;
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

pub const ViewBillingPaginator = struct {
    client: *Client,
    params: view_billing.ViewBillingInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !view_billing.ViewBillingOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try view_billing.execute(self.client, allocator, self.params, options);

        const next_token: ?[]const u8 = output.next_page_marker;
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

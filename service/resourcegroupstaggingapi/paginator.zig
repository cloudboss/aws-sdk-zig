const aws = @import("aws");
const std = @import("std");

const CallOptions = @import("call_options.zig").CallOptions;
const Client = @import("client.zig").Client;

const get_compliance_summary = @import("get_compliance_summary.zig");
const get_resources = @import("get_resources.zig");
const get_tag_keys = @import("get_tag_keys.zig");
const get_tag_values = @import("get_tag_values.zig");
const list_required_tags = @import("list_required_tags.zig");

pub const GetComplianceSummaryPaginator = struct {
    client: *Client,
    params: get_compliance_summary.GetComplianceSummaryInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_compliance_summary.GetComplianceSummaryOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.pagination_token = self.next_token;

        const output = try get_compliance_summary.execute(self.client, allocator, self.params, options);

        if (output.pagination_token) |token| {
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

pub const GetResourcesPaginator = struct {
    client: *Client,
    params: get_resources.GetResourcesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_resources.GetResourcesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.pagination_token = self.next_token;

        const output = try get_resources.execute(self.client, allocator, self.params, options);

        if (output.pagination_token) |token| {
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

pub const GetTagKeysPaginator = struct {
    client: *Client,
    params: get_tag_keys.GetTagKeysInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_tag_keys.GetTagKeysOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.pagination_token = self.next_token;

        const output = try get_tag_keys.execute(self.client, allocator, self.params, options);

        if (output.pagination_token) |token| {
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

pub const GetTagValuesPaginator = struct {
    client: *Client,
    params: get_tag_values.GetTagValuesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_tag_values.GetTagValuesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.pagination_token = self.next_token;

        const output = try get_tag_values.execute(self.client, allocator, self.params, options);

        if (output.pagination_token) |token| {
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

pub const ListRequiredTagsPaginator = struct {
    client: *Client,
    params: list_required_tags.ListRequiredTagsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_required_tags.ListRequiredTagsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try list_required_tags.execute(self.client, allocator, self.params, options);

        if (output.next_token) |token| {
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

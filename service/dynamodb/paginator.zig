const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const list_contributor_insights = @import("list_contributor_insights.zig");
const list_exports = @import("list_exports.zig");
const list_imports = @import("list_imports.zig");
const list_tables = @import("list_tables.zig");
const query_ = @import("query.zig");
const scan_ = @import("scan.zig");
const AttributeValue = @import("attribute_value.zig").AttributeValue;

pub const ListContributorInsightsPaginator = struct {
    client: *Client,
    params: list_contributor_insights.ListContributorInsightsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_contributor_insights.Options) !list_contributor_insights.ListContributorInsightsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try list_contributor_insights.execute(self.client, self.params, options);

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

pub const ListExportsPaginator = struct {
    client: *Client,
    params: list_exports.ListExportsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_exports.Options) !list_exports.ListExportsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try list_exports.execute(self.client, self.params, options);

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

pub const ListImportsPaginator = struct {
    client: *Client,
    params: list_imports.ListImportsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_imports.Options) !list_imports.ListImportsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try list_imports.execute(self.client, self.params, options);

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

pub const ListTablesPaginator = struct {
    client: *Client,
    params: list_tables.ListTablesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_tables.Options) !list_tables.ListTablesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.exclusive_start_table_name = self.next_token;

        const output = try list_tables.execute(self.client, self.params, options);

        if (output.last_evaluated_table_name) |token| {
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

pub const QueryPaginator = struct {
    client: *Client,
    params: query_.QueryInput,
    next_token: ?[]const aws.map.MapEntry(AttributeValue) = null,
    done: bool = false,
    allocator: std.mem.Allocator,
    prev_output: ?query_.QueryOutput = null,

    const Self = @This();

    pub fn next(self: *Self, options: query_.Options) !query_.QueryOutput {
        if (self.prev_output) |*prev| {
            prev.deinit();
            self.prev_output = null;
        }
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.exclusive_start_key = self.next_token;

        const output = try query_.execute(self.client, self.params, options);

        if (output.last_evaluated_key) |token| {
            if (token.len > 0) {
                self.next_token = token;
            } else {
                self.next_token = null;
                self.done = true;
            }
        } else {
            self.next_token = null;
            self.done = true;
        }

        self.prev_output = output;
        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.prev_output) |*prev| {
            prev.deinit();
        }
    }
};

pub const ScanPaginator = struct {
    client: *Client,
    params: scan_.ScanInput,
    next_token: ?[]const aws.map.MapEntry(AttributeValue) = null,
    done: bool = false,
    allocator: std.mem.Allocator,
    prev_output: ?scan_.ScanOutput = null,

    const Self = @This();

    pub fn next(self: *Self, options: scan_.Options) !scan_.ScanOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.exclusive_start_key = self.next_token;

        const output = try scan_.execute(self.client, self.params, options);

        // Deinit prev after execute() — next_token points into prev's arena
        if (self.prev_output) |*prev| {
            prev.deinit();
            self.prev_output = null;
        }

        if (output.last_evaluated_key) |token| {
            if (token.len > 0) {
                self.next_token = token;
            } else {
                self.next_token = null;
                self.done = true;
            }
        } else {
            self.next_token = null;
            self.done = true;
        }

        self.prev_output = output;
        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.prev_output) |*prev| {
            prev.deinit();
        }
    }
};

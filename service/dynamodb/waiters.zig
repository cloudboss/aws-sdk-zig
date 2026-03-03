const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const describe_contributor_insights = @import("describe_contributor_insights.zig");
const describe_export = @import("describe_export.zig");
const describe_import = @import("describe_import.zig");
const describe_table = @import("describe_table.zig");

pub const ContributorInsightsEnabledWaiter = struct {
    client: *Client,
    params: describe_contributor_insights.DescribeContributorInsightsInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 20,
        .max_delay_s = 120,
        .max_wait_time_s = 300,
    },

    const Self = @This();

    pub fn wait(self: *Self) aws.waiter.WaiterError!void {
        const start = std.time.timestamp();
        var delay_s: u32 = self.config.min_delay_s;

        while (true) {
            const state = self.poll();

            switch (state) {
                .success => return,
                .failure => return error.WaiterFailed,
                .retry => {},
            }

            const elapsed: u32 = @intCast(std.time.timestamp() - start);
            if (elapsed >= self.config.max_wait_time_s) {
                return error.WaiterTimedOut;
            }

            const jittered = aws.waiter.jitteredDelay(self.config.min_delay_s, delay_s);
            std.Thread.sleep(@as(u64, jittered) * std.time.ns_per_s);
            delay_s = @min(delay_s * 2, self.config.max_delay_s);
        }
    }

    fn poll(self: *Self) aws.waiter.AcceptorState {
        var arena = std.heap.ArenaAllocator.init(self.client.allocator);
        defer arena.deinit();

        const output = self.client.describeContributorInsights(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.contributor_insights_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "ENABLED")) {
                return .success;
            }
        }
        if (output.contributor_insights_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "FAILED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const ExportCompletedWaiter = struct {
    client: *Client,
    params: describe_export.DescribeExportInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 20,
        .max_delay_s = 120,
        .max_wait_time_s = 300,
    },

    const Self = @This();

    pub fn wait(self: *Self) aws.waiter.WaiterError!void {
        const start = std.time.timestamp();
        var delay_s: u32 = self.config.min_delay_s;

        while (true) {
            const state = self.poll();

            switch (state) {
                .success => return,
                .failure => return error.WaiterFailed,
                .retry => {},
            }

            const elapsed: u32 = @intCast(std.time.timestamp() - start);
            if (elapsed >= self.config.max_wait_time_s) {
                return error.WaiterTimedOut;
            }

            const jittered = aws.waiter.jitteredDelay(self.config.min_delay_s, delay_s);
            std.Thread.sleep(@as(u64, jittered) * std.time.ns_per_s);
            delay_s = @min(delay_s * 2, self.config.max_delay_s);
        }
    }

    fn poll(self: *Self) aws.waiter.AcceptorState {
        var arena = std.heap.ArenaAllocator.init(self.client.allocator);
        defer arena.deinit();

        const output = self.client.describeExport(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.export_description) |val_0| {
            if (val_0.export_status) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "COMPLETED")) {
                    return .success;
                }
            }
        }
        if (output.export_description) |val_0| {
            if (val_0.export_status) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "FAILED")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const ImportCompletedWaiter = struct {
    client: *Client,
    params: describe_import.DescribeImportInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 20,
        .max_delay_s = 120,
        .max_wait_time_s = 300,
    },

    const Self = @This();

    pub fn wait(self: *Self) aws.waiter.WaiterError!void {
        const start = std.time.timestamp();
        var delay_s: u32 = self.config.min_delay_s;

        while (true) {
            const state = self.poll();

            switch (state) {
                .success => return,
                .failure => return error.WaiterFailed,
                .retry => {},
            }

            const elapsed: u32 = @intCast(std.time.timestamp() - start);
            if (elapsed >= self.config.max_wait_time_s) {
                return error.WaiterTimedOut;
            }

            const jittered = aws.waiter.jitteredDelay(self.config.min_delay_s, delay_s);
            std.Thread.sleep(@as(u64, jittered) * std.time.ns_per_s);
            delay_s = @min(delay_s * 2, self.config.max_delay_s);
        }
    }

    fn poll(self: *Self) aws.waiter.AcceptorState {
        var arena = std.heap.ArenaAllocator.init(self.client.allocator);
        defer arena.deinit();

        const output = self.client.describeImport(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.import_table_description) |val_0| {
            if (val_0.import_status) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "COMPLETED")) {
                    return .success;
                }
            }
        }
        if (output.import_table_description) |val_0| {
            if (val_0.import_status) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "FAILED")) {
                    return .failure;
                }
            }
        }
        if (output.import_table_description) |val_0| {
            if (val_0.import_status) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "CANCELLED")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const TableExistsWaiter = struct {
    client: *Client,
    params: describe_table.DescribeTableInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 20,
        .max_delay_s = 120,
        .max_wait_time_s = 300,
    },

    const Self = @This();

    pub fn wait(self: *Self) aws.waiter.WaiterError!void {
        const start = std.time.timestamp();
        var delay_s: u32 = self.config.min_delay_s;

        while (true) {
            const state = self.poll();

            switch (state) {
                .success => return,
                .failure => return error.WaiterFailed,
                .retry => {},
            }

            const elapsed: u32 = @intCast(std.time.timestamp() - start);
            if (elapsed >= self.config.max_wait_time_s) {
                return error.WaiterTimedOut;
            }

            const jittered = aws.waiter.jitteredDelay(self.config.min_delay_s, delay_s);
            std.Thread.sleep(@as(u64, jittered) * std.time.ns_per_s);
            delay_s = @min(delay_s * 2, self.config.max_delay_s);
        }
    }

    fn poll(self: *Self) aws.waiter.AcceptorState {
        var arena = std.heap.ArenaAllocator.init(self.client.allocator);
        defer arena.deinit();

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        const output = self.client.describeTable(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ResourceNotFoundException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.table) |val_0| {
            if (val_0.table_status) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "ACTIVE")) {
                    return .success;
                }
            }
        }
        return .retry;
    }
};

pub const TableNotExistsWaiter = struct {
    client: *Client,
    params: describe_table.DescribeTableInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 20,
        .max_delay_s = 120,
        .max_wait_time_s = 300,
    },

    const Self = @This();

    pub fn wait(self: *Self) aws.waiter.WaiterError!void {
        const start = std.time.timestamp();
        var delay_s: u32 = self.config.min_delay_s;

        while (true) {
            const state = self.poll();

            switch (state) {
                .success => return,
                .failure => return error.WaiterFailed,
                .retry => {},
            }

            const elapsed: u32 = @intCast(std.time.timestamp() - start);
            if (elapsed >= self.config.max_wait_time_s) {
                return error.WaiterTimedOut;
            }

            const jittered = aws.waiter.jitteredDelay(self.config.min_delay_s, delay_s);
            std.Thread.sleep(@as(u64, jittered) * std.time.ns_per_s);
            delay_s = @min(delay_s * 2, self.config.max_delay_s);
        }
    }

    fn poll(self: *Self) aws.waiter.AcceptorState {
        var arena = std.heap.ArenaAllocator.init(self.client.allocator);
        defer arena.deinit();

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        _ = self.client.describeTable(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ResourceNotFoundException")) {
                    return .success;
                }
            }
            return .retry;
        };

        return .retry;
    }
};

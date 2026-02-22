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
        var output = self.client.describeContributorInsights(self.params, .{}) catch  {
            return .retry;
        };
        defer output.deinit();

        if (output.contributor_insights_status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "ENABLED")) {
                return .success;
            }
        }
        if (output.contributor_insights_status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "FAILED")) {
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
        var output = self.client.describeExport(self.params, .{}) catch  {
            return .retry;
        };
        defer output.deinit();

        if (output.export_description) |val_0| {
            if (val_0.export_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "COMPLETED")) {
                    return .success;
                }
            }
        }
        if (output.export_description) |val_0| {
            if (val_0.export_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "FAILED")) {
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
        var output = self.client.describeImport(self.params, .{}) catch  {
            return .retry;
        };
        defer output.deinit();

        if (output.import_table_description) |val_0| {
            if (val_0.import_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "COMPLETED")) {
                    return .success;
                }
            }
        }
        if (output.import_table_description) |val_0| {
            if (val_0.import_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "FAILED")) {
                    return .failure;
                }
            }
        }
        if (output.import_table_description) |val_0| {
            if (val_0.import_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "CANCELLED")) {
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
        var diagnostic: @import("errors.zig").ServiceError = undefined;
        var output = self.client.describeTable(self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ResourceNotFoundException")) {
                    return .retry;
                }
            }
            return .retry;
        };
        defer output.deinit();

        if (output.table) |val_0| {
            if (val_0.table_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "ACTIVE")) {
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
        var diagnostic: @import("errors.zig").ServiceError = undefined;
        var output_ = self.client.describeTable(self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ResourceNotFoundException")) {
                    return .success;
                }
            }
            return .retry;
        };
        defer output_.deinit();

        return .retry;
    }
};

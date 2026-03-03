const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const describe_bot_alias = @import("describe_bot_alias.zig");
const describe_bot = @import("describe_bot.zig");
const describe_export = @import("describe_export.zig");
const describe_import = @import("describe_import.zig");
const describe_bot_locale = @import("describe_bot_locale.zig");
const describe_bot_version = @import("describe_bot_version.zig");

pub const BotAliasAvailableWaiter = struct {
    client: *Client,
    params: describe_bot_alias.DescribeBotAliasInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 10,
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

        const output = self.client.describeBotAlias(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.bot_alias_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Available")) {
                return .success;
            }
        }
        if (output.bot_alias_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Failed")) {
                return .failure;
            }
        }
        if (output.bot_alias_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Deleting")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const BotAvailableWaiter = struct {
    client: *Client,
    params: describe_bot.DescribeBotInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 10,
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

        const output = self.client.describeBot(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.bot_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Available")) {
                return .success;
            }
        }
        if (output.bot_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Deleting")) {
                return .failure;
            }
        }
        if (output.bot_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Failed")) {
                return .failure;
            }
        }
        if (output.bot_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Inactive")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const BotExportCompletedWaiter = struct {
    client: *Client,
    params: describe_export.DescribeExportInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 10,
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

        if (output.export_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Completed")) {
                return .success;
            }
        }
        if (output.export_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Deleting")) {
                return .failure;
            }
        }
        if (output.export_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Failed")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const BotImportCompletedWaiter = struct {
    client: *Client,
    params: describe_import.DescribeImportInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 10,
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

        if (output.import_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Completed")) {
                return .success;
            }
        }
        if (output.import_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Deleting")) {
                return .failure;
            }
        }
        if (output.import_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Failed")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const BotLocaleBuiltWaiter = struct {
    client: *Client,
    params: describe_bot_locale.DescribeBotLocaleInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 10,
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

        const output = self.client.describeBotLocale(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.bot_locale_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Built")) {
                return .success;
            }
        }
        if (output.bot_locale_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Deleting")) {
                return .failure;
            }
        }
        if (output.bot_locale_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Failed")) {
                return .failure;
            }
        }
        if (output.bot_locale_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "NotBuilt")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const BotLocaleCreatedWaiter = struct {
    client: *Client,
    params: describe_bot_locale.DescribeBotLocaleInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 10,
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

        const output = self.client.describeBotLocale(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.bot_locale_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Built")) {
                return .success;
            }
        }
        if (output.bot_locale_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "ReadyExpressTesting")) {
                return .success;
            }
        }
        if (output.bot_locale_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "NotBuilt")) {
                return .success;
            }
        }
        if (output.bot_locale_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Deleting")) {
                return .failure;
            }
        }
        if (output.bot_locale_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Failed")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const BotLocaleExpressTestingAvailableWaiter = struct {
    client: *Client,
    params: describe_bot_locale.DescribeBotLocaleInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 10,
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

        const output = self.client.describeBotLocale(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.bot_locale_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Built")) {
                return .success;
            }
        }
        if (output.bot_locale_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "ReadyExpressTesting")) {
                return .success;
            }
        }
        if (output.bot_locale_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Deleting")) {
                return .failure;
            }
        }
        if (output.bot_locale_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Failed")) {
                return .failure;
            }
        }
        if (output.bot_locale_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "NotBuilt")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const BotVersionAvailableWaiter = struct {
    client: *Client,
    params: describe_bot_version.DescribeBotVersionInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 10,
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
        const output = self.client.describeBotVersion(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ResourceNotFoundException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.bot_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Available")) {
                return .success;
            }
        }
        if (output.bot_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Deleting")) {
                return .failure;
            }
        }
        if (output.bot_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Failed")) {
                return .failure;
            }
        }
        return .retry;
    }
};

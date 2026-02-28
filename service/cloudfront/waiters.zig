const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const get_distribution = @import("get_distribution.zig");
const get_invalidation = @import("get_invalidation.zig");
const get_invalidation_for_distribution_tenant = @import("get_invalidation_for_distribution_tenant.zig");
const get_streaming_distribution = @import("get_streaming_distribution.zig");

pub const DistributionDeployedWaiter = struct {
    client: *Client,
    params: get_distribution.GetDistributionInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 60,
        .max_delay_s = 2100,
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

        const output = self.client.getDistribution(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.distribution) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "Deployed")) {
                    return .success;
                }
            }
        }
        return .retry;
    }
};

pub const InvalidationCompletedWaiter = struct {
    client: *Client,
    params: get_invalidation.GetInvalidationInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 20,
        .max_delay_s = 600,
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

        const output = self.client.getInvalidation(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.invalidation) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "Completed")) {
                    return .success;
                }
            }
        }
        return .retry;
    }
};

pub const InvalidationForDistributionTenantCompletedWaiter = struct {
    client: *Client,
    params: get_invalidation_for_distribution_tenant.GetInvalidationForDistributionTenantInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 20,
        .max_delay_s = 600,
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

        const output = self.client.getInvalidationForDistributionTenant(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.invalidation) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "Completed")) {
                    return .success;
                }
            }
        }
        return .retry;
    }
};

pub const StreamingDistributionDeployedWaiter = struct {
    client: *Client,
    params: get_streaming_distribution.GetStreamingDistributionInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 60,
        .max_delay_s = 1500,
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

        const output = self.client.getStreamingDistribution(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.streaming_distribution) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "Deployed")) {
                    return .success;
                }
            }
        }
        return .retry;
    }
};

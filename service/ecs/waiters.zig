const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const describe_daemon = @import("describe_daemon.zig");
const describe_daemon_task_definition = @import("describe_daemon_task_definition.zig");

pub const DaemonActiveWaiter = struct {
    client: *Client,
    params: describe_daemon.DescribeDaemonInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 15,
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

        const output = self.client.describeDaemon(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.daemon) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "ACTIVE")) {
                    return .success;
                }
            }
        }
        if (output.daemon) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "DELETE_IN_PROGRESS")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const DaemonTaskDefinitionActiveWaiter = struct {
    client: *Client,
    params: describe_daemon_task_definition.DescribeDaemonTaskDefinitionInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 15,
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

        const output = self.client.describeDaemonTaskDefinition(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.daemon_task_definition) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "ACTIVE")) {
                    return .success;
                }
            }
        }
        if (output.daemon_task_definition) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "DELETE_IN_PROGRESS")) {
                    return .failure;
                }
            }
        }
        if (output.daemon_task_definition) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "DELETED")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const DaemonTaskDefinitionDeletedWaiter = struct {
    client: *Client,
    params: describe_daemon_task_definition.DescribeDaemonTaskDefinitionInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 15,
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

        const output = self.client.describeDaemonTaskDefinition(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.daemon_task_definition) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "DELETED")) {
                    return .success;
                }
            }
        }
        return .retry;
    }
};

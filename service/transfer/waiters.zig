const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const describe_server = @import("describe_server.zig");

pub const ServerOfflineWaiter = struct {
    client: *Client,
    params: describe_server.DescribeServerInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 30,
        .max_delay_s = 3600,
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

        const output = self.client.describeServer(arena.allocator(), self.params, .{}) catch {
            return .retry;
        };

        if (output.server) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "OFFLINE")) {
                    return .success;
                }
            }
        }
        if (output.server) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "STOP_FAILED")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const ServerOnlineWaiter = struct {
    client: *Client,
    params: describe_server.DescribeServerInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 30,
        .max_delay_s = 3600,
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

        const output = self.client.describeServer(arena.allocator(), self.params, .{}) catch {
            return .retry;
        };

        if (output.server) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "ONLINE")) {
                    return .success;
                }
            }
        }
        if (output.server) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "START_FAILED")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

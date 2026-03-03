const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const describe_cluster = @import("describe_cluster.zig");
const describe_step = @import("describe_step.zig");

pub const ClusterRunningWaiter = struct {
    client: *Client,
    params: describe_cluster.DescribeClusterInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 30,
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

        const output = self.client.describeCluster(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.cluster) |val_0| {
            if (val_0.status) |val_1| {
                if (val_1.state) |val_2| {
                    if (std.mem.eql(u8, val_2.wireName(), "RUNNING")) {
                        return .success;
                    }
                }
            }
        }
        if (output.cluster) |val_0| {
            if (val_0.status) |val_1| {
                if (val_1.state) |val_2| {
                    if (std.mem.eql(u8, val_2.wireName(), "WAITING")) {
                        return .success;
                    }
                }
            }
        }
        if (output.cluster) |val_0| {
            if (val_0.status) |val_1| {
                if (val_1.state) |val_2| {
                    if (std.mem.eql(u8, val_2.wireName(), "TERMINATING")) {
                        return .failure;
                    }
                }
            }
        }
        if (output.cluster) |val_0| {
            if (val_0.status) |val_1| {
                if (val_1.state) |val_2| {
                    if (std.mem.eql(u8, val_2.wireName(), "TERMINATED")) {
                        return .failure;
                    }
                }
            }
        }
        if (output.cluster) |val_0| {
            if (val_0.status) |val_1| {
                if (val_1.state) |val_2| {
                    if (std.mem.eql(u8, val_2.wireName(), "TERMINATED_WITH_ERRORS")) {
                        return .failure;
                    }
                }
            }
        }
        return .retry;
    }
};

pub const ClusterTerminatedWaiter = struct {
    client: *Client,
    params: describe_cluster.DescribeClusterInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 30,
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

        const output = self.client.describeCluster(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.cluster) |val_0| {
            if (val_0.status) |val_1| {
                if (val_1.state) |val_2| {
                    if (std.mem.eql(u8, val_2.wireName(), "TERMINATED")) {
                        return .success;
                    }
                }
            }
        }
        if (output.cluster) |val_0| {
            if (val_0.status) |val_1| {
                if (val_1.state) |val_2| {
                    if (std.mem.eql(u8, val_2.wireName(), "TERMINATED_WITH_ERRORS")) {
                        return .failure;
                    }
                }
            }
        }
        return .retry;
    }
};

pub const StepCompleteWaiter = struct {
    client: *Client,
    params: describe_step.DescribeStepInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 30,
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

        const output = self.client.describeStep(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.step) |val_0| {
            if (val_0.status) |val_1| {
                if (val_1.state) |val_2| {
                    if (std.mem.eql(u8, val_2.wireName(), "COMPLETED")) {
                        return .success;
                    }
                }
            }
        }
        if (output.step) |val_0| {
            if (val_0.status) |val_1| {
                if (val_1.state) |val_2| {
                    if (std.mem.eql(u8, val_2.wireName(), "FAILED")) {
                        return .failure;
                    }
                }
            }
        }
        if (output.step) |val_0| {
            if (val_0.status) |val_1| {
                if (val_1.state) |val_2| {
                    if (std.mem.eql(u8, val_2.wireName(), "CANCELLED")) {
                        return .failure;
                    }
                }
            }
        }
        return .retry;
    }
};

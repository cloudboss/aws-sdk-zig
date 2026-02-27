const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const get_deployment = @import("get_deployment.zig");
const get_environment = @import("get_environment.zig");

pub const DeploymentCompleteWaiter = struct {
    client: *Client,
    params: get_deployment.GetDeploymentInput,
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

        const output = self.client.getDeployment(arena.allocator(), self.params, .{}) catch {
            return .retry;
        };

        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "COMPLETE")) {
                return .success;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "ROLLED_BACK")) {
                return .failure;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "REVERTED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const EnvironmentReadyForDeploymentWaiter = struct {
    client: *Client,
    params: get_environment.GetEnvironmentInput,
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

        const output = self.client.getEnvironment(arena.allocator(), self.params, .{}) catch {
            return .retry;
        };

        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "ReadyForDeployment")) {
                return .success;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "RolledBack")) {
                return .failure;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "Reverted")) {
                return .failure;
            }
        }
        return .retry;
    }
};

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const get_connection = @import("get_connection.zig");

pub const ConnectionAvailableWaiter = struct {
    client: *Client,
    params: get_connection.GetConnectionInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 30,
        .max_delay_s = 120,
        .max_wait_time_s = 300,
    },

    const Self = @This();

    pub fn wait(self: *Self) aws.waiter.WaiterError!void {
        const io = self.client.config.io;
        const start = std.Io.Clock.real.now(io).toSeconds();
        var delay_s: u32 = self.config.min_delay_s;

        while (true) {
            const state = self.poll();

            switch (state) {
                .success => return,
                .failure => return error.WaiterFailed,
                .retry => {},
            }

            const elapsed: u32 = @intCast(std.Io.Clock.real.now(io).toSeconds() - start);
            if (elapsed >= self.config.max_wait_time_s) {
                return error.WaiterTimedOut;
            }

            const jittered = aws.waiter.jitteredDelay(io, self.config.min_delay_s, delay_s);
            io.sleep(.fromSeconds(@intCast(jittered)), .awake) catch {};
            delay_s = @min(delay_s * 2, self.config.max_delay_s);
        }
    }

    fn poll(self: *Self) aws.waiter.AcceptorState {
        var arena = std.heap.ArenaAllocator.init(self.client.allocator);
        defer arena.deinit();

        const output = self.client.getConnection(arena.allocator(), self.params, .{}) catch {
            return .retry;
        };

        if (output.connection) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "available")) {
                    return .success;
                }
            }
        }
        if (output.connection) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "deleted")) {
                    return .failure;
                }
            }
        }
        if (output.connection) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "down")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const ConnectionDeletedWaiter = struct {
    client: *Client,
    params: get_connection.GetConnectionInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 30,
        .max_delay_s = 120,
        .max_wait_time_s = 300,
    },

    const Self = @This();

    pub fn wait(self: *Self) aws.waiter.WaiterError!void {
        const io = self.client.config.io;
        const start = std.Io.Clock.real.now(io).toSeconds();
        var delay_s: u32 = self.config.min_delay_s;

        while (true) {
            const state = self.poll();

            switch (state) {
                .success => return,
                .failure => return error.WaiterFailed,
                .retry => {},
            }

            const elapsed: u32 = @intCast(std.Io.Clock.real.now(io).toSeconds() - start);
            if (elapsed >= self.config.max_wait_time_s) {
                return error.WaiterTimedOut;
            }

            const jittered = aws.waiter.jitteredDelay(io, self.config.min_delay_s, delay_s);
            io.sleep(.fromSeconds(@intCast(jittered)), .awake) catch {};
            delay_s = @min(delay_s * 2, self.config.max_delay_s);
        }
    }

    fn poll(self: *Self) aws.waiter.AcceptorState {
        var arena = std.heap.ArenaAllocator.init(self.client.allocator);
        defer arena.deinit();

        const output = self.client.getConnection(arena.allocator(), self.params, .{}) catch {
            return .retry;
        };

        if (output.connection) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "deleted")) {
                    return .success;
                }
            }
        }
        return .retry;
    }
};

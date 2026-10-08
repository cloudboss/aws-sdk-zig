const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const get_registry = @import("get_registry.zig");
const get_registry_record = @import("get_registry_record.zig");

pub const RegistryReadyWaiter = struct {
    client: *Client,
    params: get_registry.GetRegistryInput,
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

        const output = self.client.getRegistry(arena.allocator(), self.params, .{}) catch {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "READY")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CREATE_FAILED")) {
                return .failure;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "UPDATE_FAILED")) {
                return .failure;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "DELETE_FAILED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const RegistryRecordApprovedWaiter = struct {
    client: *Client,
    params: get_registry_record.GetRegistryRecordInput,
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

        const output = self.client.getRegistryRecord(arena.allocator(), self.params, .{}) catch {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "APPROVED")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "REJECTED")) {
                return .failure;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CREATE_FAILED")) {
                return .failure;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "UPDATE_FAILED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

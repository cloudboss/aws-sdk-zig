const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const get_channel = @import("get_channel.zig");
const get_space = @import("get_space.zig");

pub const ChannelCreatedWaiter = struct {
    client: *Client,
    params: get_channel.GetChannelInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 2,
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

        const output = self.client.getChannel(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.channel_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CREATED")) {
                return .success;
            }
        }
        if (output.channel_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CREATE_FAILED")) {
                return .failure;
            }
        }
        if (output.channel_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CREATING")) {
                return .retry;
            }
        }
        return .retry;
    }
};

pub const ChannelDeletedWaiter = struct {
    client: *Client,
    params: get_channel.GetChannelInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 2,
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

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        const output = self.client.getChannel(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ResourceNotFoundException")) {
                    return .success;
                }
            }
            return .retry;
        };

        if (output.channel_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "DELETED")) {
                return .success;
            }
        }
        if (output.channel_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "DELETE_FAILED")) {
                return .failure;
            }
        }
        if (output.channel_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "DELETING")) {
                return .retry;
            }
        }
        return .retry;
    }
};

pub const SpaceCreatedWaiter = struct {
    client: *Client,
    params: get_space.GetSpaceInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 300,
        .max_delay_s = 7200,
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

        const output = self.client.getSpace(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CREATED")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CREATE_FAILED")) {
                return .failure;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CREATING")) {
                return .retry;
            }
        }
        return .retry;
    }
};

pub const SpaceDeletedWaiter = struct {
    client: *Client,
    params: get_space.GetSpaceInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 300,
        .max_delay_s = 7200,
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

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        const output = self.client.getSpace(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ResourceNotFoundException")) {
                    return .success;
                }
            }
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "DELETED")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "DELETE_FAILED")) {
                return .failure;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "DELETING")) {
                return .retry;
            }
        }
        return .retry;
    }
};

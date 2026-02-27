const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const get_application = @import("get_application.zig");
const get_stream_group = @import("get_stream_group.zig");
const get_stream_session = @import("get_stream_session.zig");

pub const ApplicationDeletedWaiter = struct {
    client: *Client,
    params: get_application.GetApplicationInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 2,
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
        _ = self.client.getApplication(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ResourceNotFoundException")) {
                    return .success;
                }
            }
            return .retry;
        };

        return .retry;
    }
};

pub const ApplicationReadyWaiter = struct {
    client: *Client,
    params: get_application.GetApplicationInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 2,
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

        const output = self.client.getApplication(arena.allocator(), self.params, .{}) catch {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "READY")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "ERROR")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const StreamGroupActiveWaiter = struct {
    client: *Client,
    params: get_stream_group.GetStreamGroupInput,
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

        const output = self.client.getStreamGroup(arena.allocator(), self.params, .{}) catch {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "ACTIVE")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "ERROR")) {
                return .failure;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "ACTIVE_WITH_ERRORS")) {
                return .failure;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "DELETING")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const StreamGroupDeletedWaiter = struct {
    client: *Client,
    params: get_stream_group.GetStreamGroupInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 30,
        .max_delay_s = 1800,
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
        _ = self.client.getStreamGroup(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ResourceNotFoundException")) {
                    return .success;
                }
            }
            return .retry;
        };

        return .retry;
    }
};

pub const StreamSessionActiveWaiter = struct {
    client: *Client,
    params: get_stream_session.GetStreamSessionInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 2,
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

        const output = self.client.getStreamSession(arena.allocator(), self.params, .{}) catch {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "ACTIVE")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "ERROR")) {
                return .failure;
            }
        }
        return .retry;
    }
};

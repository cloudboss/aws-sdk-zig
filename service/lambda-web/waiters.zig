const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const get_web_function = @import("get_web_function.zig");
const get_web_function_endpoint = @import("get_web_function_endpoint.zig");
const get_web_function_revision = @import("get_web_function_revision.zig");

pub const WebFunctionActiveWaiter = struct {
    client: *Client,
    params: get_web_function.GetWebFunctionInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 1,
        .max_delay_s = 300,
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

        const output = self.client.getWebFunction(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.state) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Active")) {
                return .success;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Failed")) {
                return .failure;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Deleting")) {
                return .failure;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Pending")) {
                return .retry;
            }
        }
        return .retry;
    }
};

pub const WebFunctionDeletedWaiter = struct {
    client: *Client,
    params: get_web_function.GetWebFunctionInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 1,
        .max_delay_s = 300,
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
        const output = self.client.getWebFunction(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ResourceNotFoundException")) {
                    return .success;
                }
            }
            return .retry;
        };

        if (output.state) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Deleting")) {
                return .retry;
            }
        }
        return .retry;
    }
};

pub const WebFunctionEndpointActiveWaiter = struct {
    client: *Client,
    params: get_web_function_endpoint.GetWebFunctionEndpointInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 1,
        .max_delay_s = 300,
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

        const output = self.client.getWebFunctionEndpoint(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.state) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Active")) {
                return .success;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Failed")) {
                return .failure;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Deleting")) {
                return .failure;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Pending")) {
                return .retry;
            }
        }
        return .retry;
    }
};

pub const WebFunctionEndpointDeletedWaiter = struct {
    client: *Client,
    params: get_web_function_endpoint.GetWebFunctionEndpointInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 1,
        .max_delay_s = 300,
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
        const output = self.client.getWebFunctionEndpoint(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ResourceNotFoundException")) {
                    return .success;
                }
            }
            return .retry;
        };

        if (output.state) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Deleting")) {
                return .retry;
            }
        }
        return .retry;
    }
};

pub const WebFunctionEndpointUpdatedWaiter = struct {
    client: *Client,
    params: get_web_function_endpoint.GetWebFunctionEndpointInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 1,
        .max_delay_s = 300,
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

        const output = self.client.getWebFunctionEndpoint(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.update_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Successful")) {
                return .success;
            }
        }
        if (output.update_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Failed")) {
                return .failure;
            }
        }
        if (output.update_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "InProgress")) {
                return .retry;
            }
        }
        return .retry;
    }
};

pub const WebFunctionRevisionActiveWaiter = struct {
    client: *Client,
    params: get_web_function_revision.GetWebFunctionRevisionInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 1,
        .max_delay_s = 300,
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

        const output = self.client.getWebFunctionRevision(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.state) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Active")) {
                return .success;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Failed")) {
                return .failure;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Pending")) {
                return .retry;
            }
        }
        return .retry;
    }
};

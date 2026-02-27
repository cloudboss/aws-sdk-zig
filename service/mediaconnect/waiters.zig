const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const describe_flow = @import("describe_flow.zig");
const get_router_input = @import("get_router_input.zig");
const get_router_output = @import("get_router_output.zig");

pub const FlowActiveWaiter = struct {
    client: *Client,
    params: describe_flow.DescribeFlowInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 3,
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
        const output = self.client.describeFlow(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerErrorException")) {
                    return .retry;
                }
                if (std.mem.eql(u8, diagnostic.code(), "ServiceUnavailableException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.flow) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "ACTIVE")) {
                    return .success;
                }
            }
        }
        if (output.flow) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "STARTING")) {
                    return .retry;
                }
            }
        }
        if (output.flow) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "UPDATING")) {
                    return .retry;
                }
            }
        }
        if (output.flow) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "STANDBY")) {
                    return .failure;
                }
            }
        }
        if (output.flow) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "ERROR")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const FlowDeletedWaiter = struct {
    client: *Client,
    params: describe_flow.DescribeFlowInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 3,
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
        const output = self.client.describeFlow(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "NotFoundException")) {
                    return .success;
                }
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerErrorException")) {
                    return .retry;
                }
                if (std.mem.eql(u8, diagnostic.code(), "ServiceUnavailableException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.flow) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "DELETING")) {
                    return .retry;
                }
            }
        }
        if (output.flow) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "ERROR")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const FlowStandbyWaiter = struct {
    client: *Client,
    params: describe_flow.DescribeFlowInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 3,
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
        const output = self.client.describeFlow(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerErrorException")) {
                    return .retry;
                }
                if (std.mem.eql(u8, diagnostic.code(), "ServiceUnavailableException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.flow) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "STANDBY")) {
                    return .success;
                }
            }
        }
        if (output.flow) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "STOPPING")) {
                    return .retry;
                }
            }
        }
        if (output.flow) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "ERROR")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const InputActiveWaiter = struct {
    client: *Client,
    params: get_router_input.GetRouterInputInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 3,
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
        const output = self.client.getRouterInput(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerErrorException")) {
                    return .retry;
                }
                if (std.mem.eql(u8, diagnostic.code(), "ServiceUnavailableException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.router_input) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "ACTIVE")) {
                    return .success;
                }
            }
        }
        if (output.router_input) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "STARTING")) {
                    return .retry;
                }
            }
        }
        if (output.router_input) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "UPDATING")) {
                    return .retry;
                }
            }
        }
        if (output.router_input) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "MIGRATING")) {
                    return .retry;
                }
            }
        }
        if (output.router_input) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "ERROR")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const InputDeletedWaiter = struct {
    client: *Client,
    params: get_router_input.GetRouterInputInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 3,
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
        const output = self.client.getRouterInput(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerErrorException")) {
                    return .retry;
                }
                if (std.mem.eql(u8, diagnostic.code(), "ServiceUnavailableException")) {
                    return .retry;
                }
                if (std.mem.eql(u8, diagnostic.code(), "NotFoundException")) {
                    return .success;
                }
            }
            return .retry;
        };

        if (output.router_input) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "DELETING")) {
                    return .retry;
                }
            }
        }
        if (output.router_input) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "ERROR")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const InputStandbyWaiter = struct {
    client: *Client,
    params: get_router_input.GetRouterInputInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 3,
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
        const output = self.client.getRouterInput(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerErrorException")) {
                    return .retry;
                }
                if (std.mem.eql(u8, diagnostic.code(), "ServiceUnavailableException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.router_input) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "STANDBY")) {
                    return .success;
                }
            }
        }
        if (output.router_input) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "STOPPING")) {
                    return .retry;
                }
            }
        }
        if (output.router_input) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "ERROR")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const OutputActiveWaiter = struct {
    client: *Client,
    params: get_router_output.GetRouterOutputInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 3,
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
        const output = self.client.getRouterOutput(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerErrorException")) {
                    return .retry;
                }
                if (std.mem.eql(u8, diagnostic.code(), "ServiceUnavailableException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.router_output) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "ACTIVE")) {
                    return .success;
                }
            }
        }
        if (output.router_output) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "STARTING")) {
                    return .retry;
                }
            }
        }
        if (output.router_output) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "UPDATING")) {
                    return .retry;
                }
            }
        }
        if (output.router_output) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "MIGRATING")) {
                    return .retry;
                }
            }
        }
        if (output.router_output) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "ERROR")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const OutputDeletedWaiter = struct {
    client: *Client,
    params: get_router_output.GetRouterOutputInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 3,
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
        const output = self.client.getRouterOutput(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerErrorException")) {
                    return .retry;
                }
                if (std.mem.eql(u8, diagnostic.code(), "ServiceUnavailableException")) {
                    return .retry;
                }
                if (std.mem.eql(u8, diagnostic.code(), "NotFoundException")) {
                    return .success;
                }
            }
            return .retry;
        };

        if (output.router_output) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "DELETING")) {
                    return .retry;
                }
            }
        }
        if (output.router_output) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "ERROR")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const OutputRoutedWaiter = struct {
    client: *Client,
    params: get_router_output.GetRouterOutputInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 3,
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
        const output = self.client.getRouterOutput(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerErrorException")) {
                    return .retry;
                }
                if (std.mem.eql(u8, diagnostic.code(), "ServiceUnavailableException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.router_output) |val_0| {
            if (val_0.routed_state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "ROUTED")) {
                    return .success;
                }
            }
        }
        if (output.router_output) |val_0| {
            if (val_0.routed_state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "ROUTING")) {
                    return .retry;
                }
            }
        }
        return .retry;
    }
};

pub const OutputStandbyWaiter = struct {
    client: *Client,
    params: get_router_output.GetRouterOutputInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 3,
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
        const output = self.client.getRouterOutput(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerErrorException")) {
                    return .retry;
                }
                if (std.mem.eql(u8, diagnostic.code(), "ServiceUnavailableException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.router_output) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "STANDBY")) {
                    return .success;
                }
            }
        }
        if (output.router_output) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "STOPPING")) {
                    return .retry;
                }
            }
        }
        if (output.router_output) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "ERROR")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const OutputUnroutedWaiter = struct {
    client: *Client,
    params: get_router_output.GetRouterOutputInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 3,
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
        const output = self.client.getRouterOutput(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerErrorException")) {
                    return .retry;
                }
                if (std.mem.eql(u8, diagnostic.code(), "ServiceUnavailableException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.router_output) |val_0| {
            if (val_0.routed_state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "UNROUTED")) {
                    return .success;
                }
            }
        }
        if (output.router_output) |val_0| {
            if (val_0.routed_state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "ROUTING")) {
                    return .retry;
                }
            }
        }
        return .retry;
    }
};

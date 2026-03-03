const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const describe_cluster = @import("describe_cluster.zig");
const describe_control_panel = @import("describe_control_panel.zig");
const describe_routing_control = @import("describe_routing_control.zig");

pub const ClusterCreatedWaiter = struct {
    client: *Client,
    params: describe_cluster.DescribeClusterInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 5,
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
        const output = self.client.describeCluster(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.cluster) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "DEPLOYED")) {
                    return .success;
                }
            }
        }
        if (output.cluster) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "PENDING")) {
                    return .retry;
                }
            }
        }
        return .retry;
    }
};

pub const ClusterDeletedWaiter = struct {
    client: *Client,
    params: describe_cluster.DescribeClusterInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 5,
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
        const output = self.client.describeCluster(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ResourceNotFoundException")) {
                    return .success;
                }
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.cluster) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "PENDING_DELETION")) {
                    return .retry;
                }
            }
        }
        return .retry;
    }
};

pub const ControlPanelCreatedWaiter = struct {
    client: *Client,
    params: describe_control_panel.DescribeControlPanelInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 5,
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
        const output = self.client.describeControlPanel(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.control_panel) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "DEPLOYED")) {
                    return .success;
                }
            }
        }
        if (output.control_panel) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "PENDING")) {
                    return .retry;
                }
            }
        }
        return .retry;
    }
};

pub const ControlPanelDeletedWaiter = struct {
    client: *Client,
    params: describe_control_panel.DescribeControlPanelInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 5,
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
        const output = self.client.describeControlPanel(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ResourceNotFoundException")) {
                    return .success;
                }
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.control_panel) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "PENDING_DELETION")) {
                    return .retry;
                }
            }
        }
        return .retry;
    }
};

pub const RoutingControlCreatedWaiter = struct {
    client: *Client,
    params: describe_routing_control.DescribeRoutingControlInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 5,
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
        const output = self.client.describeRoutingControl(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.routing_control) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "DEPLOYED")) {
                    return .success;
                }
            }
        }
        if (output.routing_control) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "PENDING")) {
                    return .retry;
                }
            }
        }
        return .retry;
    }
};

pub const RoutingControlDeletedWaiter = struct {
    client: *Client,
    params: describe_routing_control.DescribeRoutingControlInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 5,
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
        const output = self.client.describeRoutingControl(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ResourceNotFoundException")) {
                    return .success;
                }
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.routing_control) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "PENDING_DELETION")) {
                    return .retry;
                }
            }
        }
        return .retry;
    }
};

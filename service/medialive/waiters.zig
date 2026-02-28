const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const describe_channel = @import("describe_channel.zig");
const describe_channel_placement_group = @import("describe_channel_placement_group.zig");
const describe_cluster = @import("describe_cluster.zig");
const describe_input = @import("describe_input.zig");
const describe_multiplex = @import("describe_multiplex.zig");
const describe_node = @import("describe_node.zig");
const get_signal_map = @import("get_signal_map.zig");

pub const ChannelCreatedWaiter = struct {
    client: *Client,
    params: describe_channel.DescribeChannelInput,
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
        const output = self.client.describeChannel(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerErrorException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "IDLE")) {
                return .success;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "CREATING")) {
                return .retry;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "CREATE_FAILED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const ChannelDeletedWaiter = struct {
    client: *Client,
    params: describe_channel.DescribeChannelInput,
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
        const output = self.client.describeChannel(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerErrorException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "DELETED")) {
                return .success;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "DELETING")) {
                return .retry;
            }
        }
        return .retry;
    }
};

pub const ChannelPlacementGroupAssignedWaiter = struct {
    client: *Client,
    params: describe_channel_placement_group.DescribeChannelPlacementGroupInput,
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
        const output = self.client.describeChannelPlacementGroup(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerErrorException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "ASSIGNED")) {
                return .success;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "ASSIGNING")) {
                return .retry;
            }
        }
        return .retry;
    }
};

pub const ChannelPlacementGroupDeletedWaiter = struct {
    client: *Client,
    params: describe_channel_placement_group.DescribeChannelPlacementGroupInput,
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
        const output = self.client.describeChannelPlacementGroup(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerErrorException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "DELETED")) {
                return .success;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "DELETING")) {
                return .retry;
            }
        }
        return .retry;
    }
};

pub const ChannelPlacementGroupUnassignedWaiter = struct {
    client: *Client,
    params: describe_channel_placement_group.DescribeChannelPlacementGroupInput,
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
        const output = self.client.describeChannelPlacementGroup(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerErrorException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "UNASSIGNED")) {
                return .success;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "UNASSIGNING")) {
                return .retry;
            }
        }
        return .retry;
    }
};

pub const ChannelRunningWaiter = struct {
    client: *Client,
    params: describe_channel.DescribeChannelInput,
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
        const output = self.client.describeChannel(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerErrorException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "RUNNING")) {
                return .success;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "STARTING")) {
                return .retry;
            }
        }
        return .retry;
    }
};

pub const ChannelStoppedWaiter = struct {
    client: *Client,
    params: describe_channel.DescribeChannelInput,
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
        const output = self.client.describeChannel(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerErrorException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "IDLE")) {
                return .success;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "STOPPING")) {
                return .retry;
            }
        }
        return .retry;
    }
};

pub const ClusterCreatedWaiter = struct {
    client: *Client,
    params: describe_cluster.DescribeClusterInput,
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
        const output = self.client.describeCluster(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerErrorException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "ACTIVE")) {
                return .success;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "CREATING")) {
                return .retry;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "CREATE_FAILED")) {
                return .failure;
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
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerErrorException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "DELETED")) {
                return .success;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "DELETING")) {
                return .retry;
            }
        }
        return .retry;
    }
};

pub const InputAttachedWaiter = struct {
    client: *Client,
    params: describe_input.DescribeInputInput,
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
        const output = self.client.describeInput(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerErrorException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "ATTACHED")) {
                return .success;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "DETACHED")) {
                return .retry;
            }
        }
        return .retry;
    }
};

pub const InputDeletedWaiter = struct {
    client: *Client,
    params: describe_input.DescribeInputInput,
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
        const output = self.client.describeInput(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerErrorException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "DELETED")) {
                return .success;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "DELETING")) {
                return .retry;
            }
        }
        return .retry;
    }
};

pub const InputDetachedWaiter = struct {
    client: *Client,
    params: describe_input.DescribeInputInput,
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
        const output = self.client.describeInput(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerErrorException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "DETACHED")) {
                return .success;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "CREATING")) {
                return .retry;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "ATTACHED")) {
                return .retry;
            }
        }
        return .retry;
    }
};

pub const MultiplexCreatedWaiter = struct {
    client: *Client,
    params: describe_multiplex.DescribeMultiplexInput,
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
        const output = self.client.describeMultiplex(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerErrorException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "IDLE")) {
                return .success;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "CREATING")) {
                return .retry;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "CREATE_FAILED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const MultiplexDeletedWaiter = struct {
    client: *Client,
    params: describe_multiplex.DescribeMultiplexInput,
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
        const output = self.client.describeMultiplex(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerErrorException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "DELETED")) {
                return .success;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "DELETING")) {
                return .retry;
            }
        }
        return .retry;
    }
};

pub const MultiplexRunningWaiter = struct {
    client: *Client,
    params: describe_multiplex.DescribeMultiplexInput,
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
        const output = self.client.describeMultiplex(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerErrorException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "RUNNING")) {
                return .success;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "STARTING")) {
                return .retry;
            }
        }
        return .retry;
    }
};

pub const MultiplexStoppedWaiter = struct {
    client: *Client,
    params: describe_multiplex.DescribeMultiplexInput,
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
        const output = self.client.describeMultiplex(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerErrorException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "IDLE")) {
                return .success;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "STOPPING")) {
                return .retry;
            }
        }
        return .retry;
    }
};

pub const NodeDeregisteredWaiter = struct {
    client: *Client,
    params: describe_node.DescribeNodeInput,
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
        const output = self.client.describeNode(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerErrorException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "DEREGISTERED")) {
                return .success;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "DEREGISTERING")) {
                return .retry;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "DRAINING")) {
                return .retry;
            }
        }
        return .retry;
    }
};

pub const NodeRegisteredWaiter = struct {
    client: *Client,
    params: describe_node.DescribeNodeInput,
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
        const output = self.client.describeNode(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "NotFoundException")) {
                    return .retry;
                }
                if (std.mem.eql(u8, diagnostic.code(), "InternalServerErrorException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "ACTIVE")) {
                return .success;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "REGISTERING")) {
                return .retry;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "REGISTRATION_FAILED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const SignalMapCreatedWaiter = struct {
    client: *Client,
    params: get_signal_map.GetSignalMapInput,
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

        const output = self.client.getSignalMap(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "CREATE_COMPLETE")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "CREATE_IN_PROGRESS")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "CREATE_FAILED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const SignalMapMonitorDeletedWaiter = struct {
    client: *Client,
    params: get_signal_map.GetSignalMapInput,
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

        const output = self.client.getSignalMap(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.monitor_deployment) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "DELETE_COMPLETE")) {
                    return .success;
                }
            }
        }
        if (output.monitor_deployment) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "DELETE_IN_PROGRESS")) {
                    return .retry;
                }
            }
        }
        if (output.monitor_deployment) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "DELETE_FAILED")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const SignalMapMonitorDeployedWaiter = struct {
    client: *Client,
    params: get_signal_map.GetSignalMapInput,
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

        const output = self.client.getSignalMap(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.monitor_deployment) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "DRY_RUN_DEPLOYMENT_COMPLETE")) {
                    return .success;
                }
            }
        }
        if (output.monitor_deployment) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "DEPLOYMENT_COMPLETE")) {
                    return .success;
                }
            }
        }
        if (output.monitor_deployment) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "DRY_RUN_DEPLOYMENT_IN_PROGRESS")) {
                    return .retry;
                }
            }
        }
        if (output.monitor_deployment) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "DEPLOYMENT_IN_PROGRESS")) {
                    return .retry;
                }
            }
        }
        if (output.monitor_deployment) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "DRY_RUN_DEPLOYMENT_FAILED")) {
                    return .failure;
                }
            }
        }
        if (output.monitor_deployment) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "DEPLOYMENT_FAILED")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const SignalMapUpdatedWaiter = struct {
    client: *Client,
    params: get_signal_map.GetSignalMapInput,
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

        const output = self.client.getSignalMap(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "UPDATE_COMPLETE")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "UPDATE_IN_PROGRESS")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "UPDATE_FAILED")) {
                return .failure;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "UPDATE_REVERTED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const get_memory = @import("get_memory.zig");
const get_policy = @import("get_policy.zig");
const get_policy_engine = @import("get_policy_engine.zig");
const get_policy_generation = @import("get_policy_generation.zig");

pub const MemoryCreatedWaiter = struct {
    client: *Client,
    params: get_memory.GetMemoryInput,
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

        const output = self.client.getMemory(arena.allocator(), self.params, .{}) catch {
            return .retry;
        };

        if (output.memory) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "CREATING")) {
                    return .retry;
                }
            }
        }
        if (output.memory) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "ACTIVE")) {
                    return .success;
                }
            }
        }
        if (output.memory) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "FAILED")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const PolicyActiveWaiter = struct {
    client: *Client,
    params: get_policy.GetPolicyInput,
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

        const output = self.client.getPolicy(arena.allocator(), self.params, .{}) catch {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "ACTIVE")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "CREATE_FAILED")) {
                return .failure;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "UPDATE_FAILED")) {
                return .failure;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "DELETE_FAILED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const PolicyDeletedWaiter = struct {
    client: *Client,
    params: get_policy.GetPolicyInput,
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
        const output = self.client.getPolicy(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ResourceNotFoundException")) {
                    return .success;
                }
            }
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "DELETING")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "DELETE_FAILED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const PolicyEngineActiveWaiter = struct {
    client: *Client,
    params: get_policy_engine.GetPolicyEngineInput,
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

        const output = self.client.getPolicyEngine(arena.allocator(), self.params, .{}) catch {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "ACTIVE")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "CREATE_FAILED")) {
                return .failure;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "UPDATE_FAILED")) {
                return .failure;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "DELETE_FAILED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const PolicyEngineDeletedWaiter = struct {
    client: *Client,
    params: get_policy_engine.GetPolicyEngineInput,
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
        const output = self.client.getPolicyEngine(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ResourceNotFoundException")) {
                    return .success;
                }
            }
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "DELETING")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "DELETE_FAILED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const PolicyGenerationCompletedWaiter = struct {
    client: *Client,
    params: get_policy_generation.GetPolicyGenerationInput,
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

        const output = self.client.getPolicyGeneration(arena.allocator(), self.params, .{}) catch {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "GENERATED")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "GENERATING")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "GENERATE_FAILED")) {
                return .failure;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "DELETE_FAILED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const get_fleet = @import("get_fleet.zig");
const get_job = @import("get_job.zig");
const get_license_endpoint = @import("get_license_endpoint.zig");
const get_queue_fleet_association = @import("get_queue_fleet_association.zig");
const get_queue_limit_association = @import("get_queue_limit_association.zig");
const get_queue = @import("get_queue.zig");

pub const FleetActiveWaiter = struct {
    client: *Client,
    params: get_fleet.GetFleetInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 5,
        .max_delay_s = 900,
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

        const output = self.client.getFleet(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "ACTIVE")) {
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
        return .retry;
    }
};

pub const JobCompleteWaiter = struct {
    client: *Client,
    params: get_job.GetJobInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 15,
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

        const output = self.client.getJob(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.task_run_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "SUCCEEDED")) {
                return .success;
            }
        }
        if (output.task_run_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "FAILED")) {
                return .success;
            }
        }
        if (output.task_run_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CANCELED")) {
                return .success;
            }
        }
        if (output.task_run_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "SUSPENDED")) {
                return .success;
            }
        }
        if (output.task_run_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "NOT_COMPATIBLE")) {
                return .success;
            }
        }
        if (output.lifecycle_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "ARCHIVED")) {
                return .success;
            }
        }
        return .retry;
    }
};

pub const JobCreateCompleteWaiter = struct {
    client: *Client,
    params: get_job.GetJobInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 1,
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

        const output = self.client.getJob(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.lifecycle_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CREATE_COMPLETE")) {
                return .success;
            }
        }
        if (output.lifecycle_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "UPDATE_IN_PROGRESS")) {
                return .success;
            }
        }
        if (output.lifecycle_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "UPDATE_FAILED")) {
                return .success;
            }
        }
        if (output.lifecycle_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "UPDATE_SUCCEEDED")) {
                return .success;
            }
        }
        if (output.lifecycle_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "UPLOAD_FAILED")) {
                return .failure;
            }
        }
        if (output.lifecycle_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CREATE_FAILED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const JobSucceededWaiter = struct {
    client: *Client,
    params: get_job.GetJobInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 15,
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

        const output = self.client.getJob(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.task_run_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "SUCCEEDED")) {
                return .success;
            }
        }
        if (output.task_run_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "FAILED")) {
                return .failure;
            }
        }
        if (output.task_run_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CANCELED")) {
                return .failure;
            }
        }
        if (output.task_run_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "SUSPENDED")) {
                return .failure;
            }
        }
        if (output.task_run_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "NOT_COMPATIBLE")) {
                return .failure;
            }
        }
        if (output.lifecycle_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "ARCHIVED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const LicenseEndpointDeletedWaiter = struct {
    client: *Client,
    params: get_license_endpoint.GetLicenseEndpointInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 10,
        .max_delay_s = 2340,
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
        const output = self.client.getLicenseEndpoint(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ResourceNotFoundException")) {
                    return .success;
                }
            }
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "NOT_READY")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const LicenseEndpointValidWaiter = struct {
    client: *Client,
    params: get_license_endpoint.GetLicenseEndpointInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 10,
        .max_delay_s = 1140,
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

        const output = self.client.getLicenseEndpoint(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "READY")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "NOT_READY")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const QueueFleetAssociationStoppedWaiter = struct {
    client: *Client,
    params: get_queue_fleet_association.GetQueueFleetAssociationInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 10,
        .max_delay_s = 600,
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

        const output = self.client.getQueueFleetAssociation(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "STOPPED")) {
                return .success;
            }
        }
        return .retry;
    }
};

pub const QueueLimitAssociationStoppedWaiter = struct {
    client: *Client,
    params: get_queue_limit_association.GetQueueLimitAssociationInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 10,
        .max_delay_s = 600,
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

        const output = self.client.getQueueLimitAssociation(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "STOPPED")) {
                return .success;
            }
        }
        return .retry;
    }
};

pub const QueueSchedulingWaiter = struct {
    client: *Client,
    params: get_queue.GetQueueInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 10,
        .max_delay_s = 700,
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

        const output = self.client.getQueue(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "SCHEDULING")) {
                return .success;
            }
        }
        return .retry;
    }
};

pub const QueueSchedulingBlockedWaiter = struct {
    client: *Client,
    params: get_queue.GetQueueInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 10,
        .max_delay_s = 300,
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

        const output = self.client.getQueue(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "SCHEDULING_BLOCKED")) {
                return .success;
            }
        }
        return .retry;
    }
};

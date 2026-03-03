const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const get_annotation_import_job = @import("get_annotation_import_job.zig");
const get_annotation_store = @import("get_annotation_store.zig");
const get_annotation_store_version = @import("get_annotation_store_version.zig");
const get_read_set_activation_job = @import("get_read_set_activation_job.zig");
const get_read_set_export_job = @import("get_read_set_export_job.zig");
const get_read_set_import_job = @import("get_read_set_import_job.zig");
const get_reference_import_job = @import("get_reference_import_job.zig");
const get_run = @import("get_run.zig");
const get_run_task = @import("get_run_task.zig");
const get_variant_import_job = @import("get_variant_import_job.zig");
const get_variant_store = @import("get_variant_store.zig");
const get_workflow = @import("get_workflow.zig");
const get_workflow_version = @import("get_workflow_version.zig");

pub const AnnotationImportJobCreatedWaiter = struct {
    client: *Client,
    params: get_annotation_import_job.GetAnnotationImportJobInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 30,
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

        const output = self.client.getAnnotationImportJob(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "SUBMITTED")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "IN_PROGRESS")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "FAILED")) {
                return .failure;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CANCELLED")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "COMPLETED")) {
                return .success;
            }
        }
        return .retry;
    }
};

pub const AnnotationStoreCreatedWaiter = struct {
    client: *Client,
    params: get_annotation_store.GetAnnotationStoreInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 30,
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

        const output = self.client.getAnnotationStore(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "ACTIVE")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CREATING")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "UPDATING")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "FAILED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const AnnotationStoreDeletedWaiter = struct {
    client: *Client,
    params: get_annotation_store.GetAnnotationStoreInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 30,
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

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        const output = self.client.getAnnotationStore(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
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
            if (std.mem.eql(u8, val_0.wireName(), "DELETING")) {
                return .retry;
            }
        }
        return .retry;
    }
};

pub const AnnotationStoreVersionCreatedWaiter = struct {
    client: *Client,
    params: get_annotation_store_version.GetAnnotationStoreVersionInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 30,
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

        const output = self.client.getAnnotationStoreVersion(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "ACTIVE")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CREATING")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "UPDATING")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "FAILED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const AnnotationStoreVersionDeletedWaiter = struct {
    client: *Client,
    params: get_annotation_store_version.GetAnnotationStoreVersionInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 30,
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

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        const output = self.client.getAnnotationStoreVersion(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
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
            if (std.mem.eql(u8, val_0.wireName(), "DELETING")) {
                return .retry;
            }
        }
        return .retry;
    }
};

pub const ReadSetActivationJobCompletedWaiter = struct {
    client: *Client,
    params: get_read_set_activation_job.GetReadSetActivationJobInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 30,
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

        const output = self.client.getReadSetActivationJob(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "COMPLETED")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "SUBMITTED")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "IN_PROGRESS")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CANCELLING")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CANCELLED")) {
                return .failure;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "FAILED")) {
                return .failure;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "COMPLETED_WITH_FAILURES")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const ReadSetExportJobCompletedWaiter = struct {
    client: *Client,
    params: get_read_set_export_job.GetReadSetExportJobInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 30,
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

        const output = self.client.getReadSetExportJob(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "COMPLETED")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "SUBMITTED")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "IN_PROGRESS")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CANCELLING")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CANCELLED")) {
                return .failure;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "FAILED")) {
                return .failure;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "COMPLETED_WITH_FAILURES")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const ReadSetImportJobCompletedWaiter = struct {
    client: *Client,
    params: get_read_set_import_job.GetReadSetImportJobInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 30,
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

        const output = self.client.getReadSetImportJob(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "COMPLETED")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "SUBMITTED")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "IN_PROGRESS")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CANCELLING")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CANCELLED")) {
                return .failure;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "FAILED")) {
                return .failure;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "COMPLETED_WITH_FAILURES")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const ReferenceImportJobCompletedWaiter = struct {
    client: *Client,
    params: get_reference_import_job.GetReferenceImportJobInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 30,
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

        const output = self.client.getReferenceImportJob(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "COMPLETED")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "SUBMITTED")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "IN_PROGRESS")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CANCELLING")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CANCELLED")) {
                return .failure;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "FAILED")) {
                return .failure;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "COMPLETED_WITH_FAILURES")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const RunCompletedWaiter = struct {
    client: *Client,
    params: get_run.GetRunInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 30,
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

        const output = self.client.getRun(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "COMPLETED")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "PENDING")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "STARTING")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "RUNNING")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "STOPPING")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "FAILED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const RunRunningWaiter = struct {
    client: *Client,
    params: get_run.GetRunInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 30,
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

        const output = self.client.getRun(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "RUNNING")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "PENDING")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "STARTING")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "FAILED")) {
                return .failure;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CANCELLED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const TaskCompletedWaiter = struct {
    client: *Client,
    params: get_run_task.GetRunTaskInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 30,
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

        const output = self.client.getRunTask(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "COMPLETED")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "PENDING")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "STARTING")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "RUNNING")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "STOPPING")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "FAILED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const TaskRunningWaiter = struct {
    client: *Client,
    params: get_run_task.GetRunTaskInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 30,
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

        const output = self.client.getRunTask(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "RUNNING")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "PENDING")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "STARTING")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "FAILED")) {
                return .failure;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CANCELLED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const VariantImportJobCreatedWaiter = struct {
    client: *Client,
    params: get_variant_import_job.GetVariantImportJobInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 30,
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

        const output = self.client.getVariantImportJob(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "SUBMITTED")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "IN_PROGRESS")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "FAILED")) {
                return .failure;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CANCELLED")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "COMPLETED")) {
                return .success;
            }
        }
        return .retry;
    }
};

pub const VariantStoreCreatedWaiter = struct {
    client: *Client,
    params: get_variant_store.GetVariantStoreInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 30,
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

        const output = self.client.getVariantStore(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "ACTIVE")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CREATING")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "UPDATING")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "FAILED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const VariantStoreDeletedWaiter = struct {
    client: *Client,
    params: get_variant_store.GetVariantStoreInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 30,
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

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        const output = self.client.getVariantStore(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
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
            if (std.mem.eql(u8, val_0.wireName(), "DELETING")) {
                return .retry;
            }
        }
        return .retry;
    }
};

pub const WorkflowActiveWaiter = struct {
    client: *Client,
    params: get_workflow.GetWorkflowInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 3,
        .max_delay_s = 30,
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

        const output = self.client.getWorkflow(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "ACTIVE")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CREATING")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "UPDATING")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "FAILED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const WorkflowVersionActiveWaiter = struct {
    client: *Client,
    params: get_workflow_version.GetWorkflowVersionInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 3,
        .max_delay_s = 30,
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

        const output = self.client.getWorkflowVersion(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "ACTIVE")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CREATING")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "UPDATING")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "FAILED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

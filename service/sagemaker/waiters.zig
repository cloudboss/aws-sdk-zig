const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const describe_endpoint = @import("describe_endpoint.zig");
const describe_image = @import("describe_image.zig");
const describe_image_version = @import("describe_image_version.zig");
const describe_notebook_instance = @import("describe_notebook_instance.zig");
const describe_processing_job = @import("describe_processing_job.zig");
const describe_training_job = @import("describe_training_job.zig");
const describe_transform_job = @import("describe_transform_job.zig");

pub const EndpointDeletedWaiter = struct {
    client: *Client,
    params: describe_endpoint.DescribeEndpointInput,
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
        const output = self.client.describeEndpoint(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ValidationException")) {
                    return .success;
                }
            }
            return .retry;
        };

        if (output.endpoint_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Failed")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const EndpointInServiceWaiter = struct {
    client: *Client,
    params: describe_endpoint.DescribeEndpointInput,
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

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        const output = self.client.describeEndpoint(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ValidationException")) {
                    return .failure;
                }
            }
            return .retry;
        };

        if (output.endpoint_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "InService")) {
                return .success;
            }
        }
        if (output.endpoint_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Failed")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const ImageCreatedWaiter = struct {
    client: *Client,
    params: describe_image.DescribeImageInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 60,
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

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        const output = self.client.describeImage(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ValidationException")) {
                    return .failure;
                }
            }
            return .retry;
        };

        if (output.image_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CREATED")) {
                return .success;
            }
        }
        if (output.image_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CREATE_FAILED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const ImageDeletedWaiter = struct {
    client: *Client,
    params: describe_image.DescribeImageInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 60,
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

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        const output = self.client.describeImage(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ResourceNotFoundException")) {
                    return .success;
                }
                if (std.mem.eql(u8, diagnostic.code(), "ValidationException")) {
                    return .failure;
                }
            }
            return .retry;
        };

        if (output.image_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "DELETE_FAILED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const ImageUpdatedWaiter = struct {
    client: *Client,
    params: describe_image.DescribeImageInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 60,
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

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        const output = self.client.describeImage(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ValidationException")) {
                    return .failure;
                }
            }
            return .retry;
        };

        if (output.image_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CREATED")) {
                return .success;
            }
        }
        if (output.image_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "UPDATE_FAILED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const ImageVersionCreatedWaiter = struct {
    client: *Client,
    params: describe_image_version.DescribeImageVersionInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 60,
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

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        const output = self.client.describeImageVersion(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ValidationException")) {
                    return .failure;
                }
            }
            return .retry;
        };

        if (output.image_version_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CREATED")) {
                return .success;
            }
        }
        if (output.image_version_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CREATE_FAILED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const ImageVersionDeletedWaiter = struct {
    client: *Client,
    params: describe_image_version.DescribeImageVersionInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 60,
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

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        const output = self.client.describeImageVersion(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ResourceNotFoundException")) {
                    return .success;
                }
                if (std.mem.eql(u8, diagnostic.code(), "ValidationException")) {
                    return .failure;
                }
            }
            return .retry;
        };

        if (output.image_version_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "DELETE_FAILED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const NotebookInstanceDeletedWaiter = struct {
    client: *Client,
    params: describe_notebook_instance.DescribeNotebookInstanceInput,
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
        const output = self.client.describeNotebookInstance(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ValidationException")) {
                    return .success;
                }
            }
            return .retry;
        };

        if (output.notebook_instance_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Failed")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const NotebookInstanceInServiceWaiter = struct {
    client: *Client,
    params: describe_notebook_instance.DescribeNotebookInstanceInput,
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

        const output = self.client.describeNotebookInstance(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.notebook_instance_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "InService")) {
                return .success;
            }
        }
        if (output.notebook_instance_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Failed")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const NotebookInstanceStoppedWaiter = struct {
    client: *Client,
    params: describe_notebook_instance.DescribeNotebookInstanceInput,
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

        const output = self.client.describeNotebookInstance(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.notebook_instance_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Stopped")) {
                return .success;
            }
        }
        if (output.notebook_instance_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Failed")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const ProcessingJobCompletedOrStoppedWaiter = struct {
    client: *Client,
    params: describe_processing_job.DescribeProcessingJobInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 60,
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

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        const output = self.client.describeProcessingJob(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ValidationException")) {
                    return .failure;
                }
            }
            return .retry;
        };

        if (output.processing_job_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Completed")) {
                return .success;
            }
        }
        if (output.processing_job_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Stopped")) {
                return .success;
            }
        }
        if (output.processing_job_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Failed")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const TrainingJobCompletedOrStoppedWaiter = struct {
    client: *Client,
    params: describe_training_job.DescribeTrainingJobInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 120,
        .max_delay_s = 21600,
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
        const output = self.client.describeTrainingJob(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ValidationException")) {
                    return .failure;
                }
            }
            return .retry;
        };

        if (output.training_job_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Completed")) {
                return .success;
            }
        }
        if (output.training_job_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Stopped")) {
                return .success;
            }
        }
        if (output.training_job_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Failed")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const TransformJobCompletedOrStoppedWaiter = struct {
    client: *Client,
    params: describe_transform_job.DescribeTransformJobInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 60,
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

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        const output = self.client.describeTransformJob(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ValidationException")) {
                    return .failure;
                }
            }
            return .retry;
        };

        if (output.transform_job_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Completed")) {
                return .success;
            }
        }
        if (output.transform_job_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Stopped")) {
                return .success;
            }
        }
        if (output.transform_job_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "Failed")) {
                return .failure;
            }
        }
        return .retry;
    }
};

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const get_component = @import("get_component.zig");
const get_environment = @import("get_environment.zig");
const get_environment_template_version = @import("get_environment_template_version.zig");
const get_service = @import("get_service.zig");
const get_service_instance = @import("get_service_instance.zig");
const get_service_template_version = @import("get_service_template_version.zig");

pub const ComponentDeletedWaiter = struct {
    client: *Client,
    params: get_component.GetComponentInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 5,
        .max_delay_s = 4999,
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
        const output = self.client.getComponent(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ResourceNotFoundException")) {
                    return .success;
                }
            }
            return .retry;
        };

        if (output.component) |val_0| {
            if (val_0.deployment_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "DELETE_FAILED")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const ComponentDeployedWaiter = struct {
    client: *Client,
    params: get_component.GetComponentInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 5,
        .max_delay_s = 4999,
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

        const output = self.client.getComponent(arena.allocator(), self.params, .{}) catch {
            return .retry;
        };

        if (output.component) |val_0| {
            if (val_0.deployment_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "SUCCEEDED")) {
                    return .success;
                }
            }
        }
        if (output.component) |val_0| {
            if (val_0.deployment_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "FAILED")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const EnvironmentDeployedWaiter = struct {
    client: *Client,
    params: get_environment.GetEnvironmentInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 5,
        .max_delay_s = 4999,
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

        const output = self.client.getEnvironment(arena.allocator(), self.params, .{}) catch {
            return .retry;
        };

        if (output.environment) |val_0| {
            if (val_0.deployment_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "SUCCEEDED")) {
                    return .success;
                }
            }
        }
        if (output.environment) |val_0| {
            if (val_0.deployment_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "FAILED")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const EnvironmentTemplateVersionRegisteredWaiter = struct {
    client: *Client,
    params: get_environment_template_version.GetEnvironmentTemplateVersionInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 2,
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

        const output = self.client.getEnvironmentTemplateVersion(arena.allocator(), self.params, .{}) catch {
            return .retry;
        };

        if (output.environment_template_version) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "DRAFT")) {
                    return .success;
                }
            }
        }
        if (output.environment_template_version) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "PUBLISHED")) {
                    return .success;
                }
            }
        }
        if (output.environment_template_version) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "REGISTRATION_FAILED")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const ServiceCreatedWaiter = struct {
    client: *Client,
    params: get_service.GetServiceInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 5,
        .max_delay_s = 4999,
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

        const output = self.client.getService(arena.allocator(), self.params, .{}) catch {
            return .retry;
        };

        if (output.service) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "ACTIVE")) {
                    return .success;
                }
            }
        }
        if (output.service) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "CREATE_FAILED_CLEANUP_COMPLETE")) {
                    return .failure;
                }
            }
        }
        if (output.service) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "CREATE_FAILED_CLEANUP_FAILED")) {
                    return .failure;
                }
            }
        }
        if (output.service) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "CREATE_FAILED")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const ServiceDeletedWaiter = struct {
    client: *Client,
    params: get_service.GetServiceInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 5,
        .max_delay_s = 4999,
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
        const output = self.client.getService(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ResourceNotFoundException")) {
                    return .success;
                }
            }
            return .retry;
        };

        if (output.service) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "DELETE_FAILED")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const ServiceInstanceDeployedWaiter = struct {
    client: *Client,
    params: get_service_instance.GetServiceInstanceInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 5,
        .max_delay_s = 4999,
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

        const output = self.client.getServiceInstance(arena.allocator(), self.params, .{}) catch {
            return .retry;
        };

        if (output.service_instance) |val_0| {
            if (val_0.deployment_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "SUCCEEDED")) {
                    return .success;
                }
            }
        }
        if (output.service_instance) |val_0| {
            if (val_0.deployment_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "FAILED")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const ServicePipelineDeployedWaiter = struct {
    client: *Client,
    params: get_service.GetServiceInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 10,
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

        const output = self.client.getService(arena.allocator(), self.params, .{}) catch {
            return .retry;
        };

        if (output.service) |val_0| {
            if (val_0.pipeline) |val_1| {
                if (val_1.deployment_status) |val_2| {
                    if (std.mem.eql(u8, @tagName(val_2), "SUCCEEDED")) {
                        return .success;
                    }
                }
            }
        }
        if (output.service) |val_0| {
            if (val_0.pipeline) |val_1| {
                if (val_1.deployment_status) |val_2| {
                    if (std.mem.eql(u8, @tagName(val_2), "FAILED")) {
                        return .failure;
                    }
                }
            }
        }
        return .retry;
    }
};

pub const ServiceTemplateVersionRegisteredWaiter = struct {
    client: *Client,
    params: get_service_template_version.GetServiceTemplateVersionInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 2,
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

        const output = self.client.getServiceTemplateVersion(arena.allocator(), self.params, .{}) catch {
            return .retry;
        };

        if (output.service_template_version) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "DRAFT")) {
                    return .success;
                }
            }
        }
        if (output.service_template_version) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "PUBLISHED")) {
                    return .success;
                }
            }
        }
        if (output.service_template_version) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "REGISTRATION_FAILED")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const ServiceUpdatedWaiter = struct {
    client: *Client,
    params: get_service.GetServiceInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 5,
        .max_delay_s = 4999,
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

        const output = self.client.getService(arena.allocator(), self.params, .{}) catch {
            return .retry;
        };

        if (output.service) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "ACTIVE")) {
                    return .success;
                }
            }
        }
        if (output.service) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "UPDATE_FAILED_CLEANUP_COMPLETE")) {
                    return .failure;
                }
            }
        }
        if (output.service) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "UPDATE_FAILED_CLEANUP_FAILED")) {
                    return .failure;
                }
            }
        }
        if (output.service) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "UPDATE_FAILED")) {
                    return .failure;
                }
            }
        }
        if (output.service) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "UPDATE_COMPLETE_CLEANUP_FAILED")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

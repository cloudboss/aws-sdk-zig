const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const get_function_configuration = @import("get_function_configuration.zig");
const get_function = @import("get_function.zig");

pub const FunctionActiveWaiter = struct {
    client: *Client,
    params: get_function_configuration.GetFunctionConfigurationInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 5,
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
        const output = self.client.getFunctionConfiguration(self.params, .{}) catch  {
            return .retry;
        };

        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "Active")) {
                return .success;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "Failed")) {
                return .failure;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "Pending")) {
                return .retry;
            }
        }
        return .retry;
    }
};

pub const FunctionActiveV2Waiter = struct {
    client: *Client,
    params: get_function.GetFunctionInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 1,
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
        const output = self.client.getFunction(self.params, .{}) catch  {
            return .retry;
        };

        if (output.configuration) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "Active")) {
                    return .success;
                }
            }
        }
        if (output.configuration) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "Failed")) {
                    return .failure;
                }
            }
        }
        if (output.configuration) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "Pending")) {
                    return .retry;
                }
            }
        }
        return .retry;
    }
};

pub const FunctionExistsWaiter = struct {
    client: *Client,
    params: get_function.GetFunctionInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 1,
        .max_delay_s = 20,
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
        var diagnostic: @import("errors.zig").ServiceError = undefined;
        _ = self.client.getFunction(self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                if (std.mem.eql(u8, diagnostic.code(), "ResourceNotFoundException")) {
                    return .retry;
                }
            }
            return .retry;
        };

        return .success;
    }
};

pub const FunctionUpdatedWaiter = struct {
    client: *Client,
    params: get_function_configuration.GetFunctionConfigurationInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 5,
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
        const output = self.client.getFunctionConfiguration(self.params, .{}) catch  {
            return .retry;
        };

        if (output.last_update_status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "Successful")) {
                return .success;
            }
        }
        if (output.last_update_status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "Failed")) {
                return .failure;
            }
        }
        if (output.last_update_status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "InProgress")) {
                return .retry;
            }
        }
        return .retry;
    }
};

pub const FunctionUpdatedV2Waiter = struct {
    client: *Client,
    params: get_function.GetFunctionInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 1,
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
        const output = self.client.getFunction(self.params, .{}) catch  {
            return .retry;
        };

        if (output.configuration) |val_0| {
            if (val_0.last_update_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "Successful")) {
                    return .success;
                }
            }
        }
        if (output.configuration) |val_0| {
            if (val_0.last_update_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "Failed")) {
                    return .failure;
                }
            }
        }
        if (output.configuration) |val_0| {
            if (val_0.last_update_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "InProgress")) {
                    return .retry;
                }
            }
        }
        return .retry;
    }
};

pub const PublishedVersionActiveWaiter = struct {
    client: *Client,
    params: get_function_configuration.GetFunctionConfigurationInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 5,
        .max_delay_s = 1560,
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
        const output = self.client.getFunctionConfiguration(self.params, .{}) catch  {
            return .retry;
        };

        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "Active")) {
                return .success;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "Failed")) {
                return .failure;
            }
        }
        if (output.state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "Pending")) {
                return .retry;
            }
        }
        return .retry;
    }
};

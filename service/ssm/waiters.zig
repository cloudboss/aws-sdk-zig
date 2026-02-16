const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const get_command_invocation = @import("get_command_invocation.zig");

pub const CommandExecutedWaiter = struct {
    client: *Client,
    params: get_command_invocation.GetCommandInvocationInput,
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
        var diagnostic: @import("errors.zig").ServiceError = undefined;
        var output = self.client.getCommandInvocation(self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                if (std.mem.eql(u8, diagnostic.code(), "InvocationDoesNotExist")) {
                    return .retry;
                }
            }
            return .retry;
        };
        defer output.deinit();

        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "Pending")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "InProgress")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "Delayed")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "Success")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "Cancelled")) {
                return .failure;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "TimedOut")) {
                return .failure;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "Failed")) {
                return .failure;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "Cancelling")) {
                return .failure;
            }
        }
        return .retry;
    }
};

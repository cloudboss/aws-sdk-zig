const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const describe_code_binding = @import("describe_code_binding.zig");

pub const CodeBindingExistsWaiter = struct {
    client: *Client,
    params: describe_code_binding.DescribeCodeBindingInput,
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
        const output = self.client.describeCodeBinding(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "NotFoundException")) {
                    return .failure;
                }
            }
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CREATE_COMPLETE")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CREATE_IN_PROGRESS")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CREATE_FAILED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

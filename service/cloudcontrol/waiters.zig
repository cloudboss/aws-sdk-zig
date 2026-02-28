const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const get_resource_request_status = @import("get_resource_request_status.zig");

pub const ResourceRequestSuccessWaiter = struct {
    client: *Client,
    params: get_resource_request_status.GetResourceRequestStatusInput,
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

        const output = self.client.getResourceRequestStatus(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.progress_event) |val_0| {
            if (val_0.operation_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "SUCCESS")) {
                    return .success;
                }
            }
        }
        if (output.progress_event) |val_0| {
            if (val_0.operation_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "FAILED")) {
                    return .failure;
                }
            }
        }
        if (output.progress_event) |val_0| {
            if (val_0.operation_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "CANCEL_COMPLETE")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

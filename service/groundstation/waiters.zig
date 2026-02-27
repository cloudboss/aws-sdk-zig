const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const describe_contact = @import("describe_contact.zig");

pub const ContactScheduledWaiter = struct {
    client: *Client,
    params: describe_contact.DescribeContactInput,
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

        const output = self.client.describeContact(arena.allocator(), self.params, .{}) catch {
            return .retry;
        };

        if (output.contact_status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "FAILED_TO_SCHEDULE")) {
                return .failure;
            }
        }
        if (output.contact_status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "SCHEDULED")) {
                return .success;
            }
        }
        return .retry;
    }
};

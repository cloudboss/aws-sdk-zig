const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const get_identity_verification_attributes = @import("get_identity_verification_attributes.zig");

pub const IdentityExistsWaiter = struct {
    client: *Client,
    params: get_identity_verification_attributes.GetIdentityVerificationAttributesInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 3,
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

        const output = self.client.getIdentityVerificationAttributes(arena.allocator(), self.params, .{}) catch {
            return .retry;
        };

        if (output.verification_attributes) |val_0| {
            if (val_0.*) |val_1| {
                if (val_1.verification_status) |val_2| {
                    if (std.mem.eql(u8, @tagName(val_2), "Success")) {
                        return .success;
                    }
                }
            }
        }
        return .retry;
    }
};

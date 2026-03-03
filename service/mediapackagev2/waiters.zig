const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const get_harvest_job = @import("get_harvest_job.zig");

pub const HarvestJobFinishedWaiter = struct {
    client: *Client,
    params: get_harvest_job.GetHarvestJobInput,
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

        const output = self.client.getHarvestJob(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "COMPLETED")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "CANCELLED")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "FAILED")) {
                return .failure;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "QUEUED")) {
                return .retry;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "IN_PROGRESS")) {
                return .retry;
            }
        }
        return .retry;
    }
};

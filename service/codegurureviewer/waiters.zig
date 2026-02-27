const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const describe_code_review = @import("describe_code_review.zig");
const describe_repository_association = @import("describe_repository_association.zig");

pub const CodeReviewCompletedWaiter = struct {
    client: *Client,
    params: describe_code_review.DescribeCodeReviewInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 10,
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

        const output = self.client.describeCodeReview(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.code_review) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "Completed")) {
                    return .success;
                }
            }
        }
        if (output.code_review) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "Failed")) {
                    return .failure;
                }
            }
        }
        if (output.code_review) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "Pending")) {
                    return .retry;
                }
            }
        }
        return .retry;
    }
};

pub const RepositoryAssociationSucceededWaiter = struct {
    client: *Client,
    params: describe_repository_association.DescribeRepositoryAssociationInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 10,
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

        const output = self.client.describeRepositoryAssociation(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.repository_association) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "Associated")) {
                    return .success;
                }
            }
        }
        if (output.repository_association) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "Failed")) {
                    return .failure;
                }
            }
        }
        if (output.repository_association) |val_0| {
            if (val_0.state) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "Associating")) {
                    return .retry;
                }
            }
        }
        return .retry;
    }
};

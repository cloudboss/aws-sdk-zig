const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const get_plan_evaluation_status = @import("get_plan_evaluation_status.zig");
const get_plan_execution = @import("get_plan_execution.zig");

pub const PlanEvaluationStatusPassedWaiter = struct {
    client: *Client,
    params: get_plan_evaluation_status.GetPlanEvaluationStatusInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 30,
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

        const output = self.client.getPlanEvaluationStatus(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.evaluation_state) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "passed")) {
                return .success;
            }
        }
        if (output.evaluation_state) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "actionRequired")) {
                return .failure;
            }
        }
        if (output.evaluation_state) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "pendingEvaluation")) {
                return .retry;
            }
        }
        return .retry;
    }
};

pub const PlanExecutionCompletedWaiter = struct {
    client: *Client,
    params: get_plan_execution.GetPlanExecutionInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 30,
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

        const output = self.client.getPlanExecution(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.execution_state) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "completed")) {
                return .success;
            }
        }
        if (output.execution_state) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "completedWithExceptions")) {
                return .success;
            }
        }
        if (output.execution_state) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "failed")) {
                return .failure;
            }
        }
        if (output.execution_state) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "canceled")) {
                return .failure;
            }
        }
        if (output.execution_state) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "planExecutionTimedOut")) {
                return .failure;
            }
        }
        return .retry;
    }
};

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const describe_image_scan_findings = @import("describe_image_scan_findings.zig");
const get_lifecycle_policy_preview = @import("get_lifecycle_policy_preview.zig");

pub const ImageScanCompleteWaiter = struct {
    client: *Client,
    params: describe_image_scan_findings.DescribeImageScanFindingsInput,
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

        const output = self.client.describeImageScanFindings(arena.allocator(), self.params, .{}) catch {
            return .retry;
        };

        if (output.image_scan_status) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "COMPLETE")) {
                    return .success;
                }
            }
        }
        if (output.image_scan_status) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "FAILED")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const LifecyclePolicyPreviewCompleteWaiter = struct {
    client: *Client,
    params: get_lifecycle_policy_preview.GetLifecyclePolicyPreviewInput,
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

        const output = self.client.getLifecyclePolicyPreview(arena.allocator(), self.params, .{}) catch {
            return .retry;
        };

        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "COMPLETE")) {
                return .success;
            }
        }
        if (output.status) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "FAILED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

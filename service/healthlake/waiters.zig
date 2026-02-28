const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const describe_fhir_datastore = @import("describe_fhir_datastore.zig");
const describe_fhir_export_job = @import("describe_fhir_export_job.zig");
const describe_fhir_import_job = @import("describe_fhir_import_job.zig");

pub const FHIRDatastoreActiveWaiter = struct {
    client: *Client,
    params: describe_fhir_datastore.DescribeFHIRDatastoreInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 60,
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

        const output = self.client.describeFhirDatastore(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.datastore_properties) |val_0| {
            if (val_0.datastore_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "ACTIVE")) {
                    return .success;
                }
            }
        }
        if (output.datastore_properties) |val_0| {
            if (val_0.datastore_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "CREATE_FAILED")) {
                    return .failure;
                }
            }
        }
        if (output.datastore_properties) |val_0| {
            if (val_0.datastore_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "DELETED")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const FHIRDatastoreDeletedWaiter = struct {
    client: *Client,
    params: describe_fhir_datastore.DescribeFHIRDatastoreInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 120,
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

        const output = self.client.describeFhirDatastore(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.datastore_properties) |val_0| {
            if (val_0.datastore_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "DELETED")) {
                    return .success;
                }
            }
        }
        return .retry;
    }
};

pub const FHIRExportJobCompletedWaiter = struct {
    client: *Client,
    params: describe_fhir_export_job.DescribeFHIRExportJobInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 120,
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

        const output = self.client.describeFhirExportJob(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.export_job_properties) |val_0| {
            if (val_0.job_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "COMPLETED")) {
                    return .success;
                }
            }
        }
        if (output.export_job_properties) |val_0| {
            if (val_0.job_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "COMPLETED_WITH_ERRORS")) {
                    return .success;
                }
            }
        }
        if (output.export_job_properties) |val_0| {
            if (val_0.job_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "CANCEL_COMPLETED")) {
                    return .failure;
                }
            }
        }
        if (output.export_job_properties) |val_0| {
            if (val_0.job_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "FAILED")) {
                    return .failure;
                }
            }
        }
        if (output.export_job_properties) |val_0| {
            if (val_0.job_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "CANCEL_FAILED")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const FHIRImportJobCompletedWaiter = struct {
    client: *Client,
    params: describe_fhir_import_job.DescribeFHIRImportJobInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 120,
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

        const output = self.client.describeFhirImportJob(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.import_job_properties) |val_0| {
            if (val_0.job_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "COMPLETED")) {
                    return .success;
                }
            }
        }
        if (output.import_job_properties) |val_0| {
            if (val_0.job_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "COMPLETED_WITH_ERRORS")) {
                    return .success;
                }
            }
        }
        if (output.import_job_properties) |val_0| {
            if (val_0.job_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "FAILED")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

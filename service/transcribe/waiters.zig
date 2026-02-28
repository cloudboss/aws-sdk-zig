const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const get_call_analytics_job = @import("get_call_analytics_job.zig");
const describe_language_model = @import("describe_language_model.zig");
const get_medical_scribe_job = @import("get_medical_scribe_job.zig");
const get_medical_transcription_job = @import("get_medical_transcription_job.zig");
const get_medical_vocabulary = @import("get_medical_vocabulary.zig");
const get_transcription_job = @import("get_transcription_job.zig");
const get_vocabulary = @import("get_vocabulary.zig");

pub const CallAnalyticsJobCompletedWaiter = struct {
    client: *Client,
    params: get_call_analytics_job.GetCallAnalyticsJobInput,
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

        const output = self.client.getCallAnalyticsJob(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.call_analytics_job) |val_0| {
            if (val_0.call_analytics_job_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "COMPLETED")) {
                    return .success;
                }
            }
        }
        if (output.call_analytics_job) |val_0| {
            if (val_0.call_analytics_job_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "FAILED")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const LanguageModelCompletedWaiter = struct {
    client: *Client,
    params: describe_language_model.DescribeLanguageModelInput,
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

        const output = self.client.describeLanguageModel(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.language_model) |val_0| {
            if (val_0.model_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "COMPLETED")) {
                    return .success;
                }
            }
        }
        if (output.language_model) |val_0| {
            if (val_0.model_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "FAILED")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const MedicalScribeJobCompletedWaiter = struct {
    client: *Client,
    params: get_medical_scribe_job.GetMedicalScribeJobInput,
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

        const output = self.client.getMedicalScribeJob(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.medical_scribe_job) |val_0| {
            if (val_0.medical_scribe_job_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "COMPLETED")) {
                    return .success;
                }
            }
        }
        if (output.medical_scribe_job) |val_0| {
            if (val_0.medical_scribe_job_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "FAILED")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const MedicalTranscriptionJobCompletedWaiter = struct {
    client: *Client,
    params: get_medical_transcription_job.GetMedicalTranscriptionJobInput,
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

        const output = self.client.getMedicalTranscriptionJob(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.medical_transcription_job) |val_0| {
            if (val_0.transcription_job_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "COMPLETED")) {
                    return .success;
                }
            }
        }
        if (output.medical_transcription_job) |val_0| {
            if (val_0.transcription_job_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "FAILED")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const MedicalVocabularyReadyWaiter = struct {
    client: *Client,
    params: get_medical_vocabulary.GetMedicalVocabularyInput,
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

        const output = self.client.getMedicalVocabulary(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.vocabulary_state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "READY")) {
                return .success;
            }
        }
        if (output.vocabulary_state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "FAILED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const TranscriptionJobCompletedWaiter = struct {
    client: *Client,
    params: get_transcription_job.GetTranscriptionJobInput,
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

        const output = self.client.getTranscriptionJob(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.transcription_job) |val_0| {
            if (val_0.transcription_job_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "COMPLETED")) {
                    return .success;
                }
            }
        }
        if (output.transcription_job) |val_0| {
            if (val_0.transcription_job_status) |val_1| {
                if (std.mem.eql(u8, @tagName(val_1), "FAILED")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};

pub const VocabularyReadyWaiter = struct {
    client: *Client,
    params: get_vocabulary.GetVocabularyInput,
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

        const output = self.client.getVocabulary(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.vocabulary_state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "READY")) {
                return .success;
            }
        }
        if (output.vocabulary_state) |val_0| {
            if (std.mem.eql(u8, @tagName(val_0), "FAILED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

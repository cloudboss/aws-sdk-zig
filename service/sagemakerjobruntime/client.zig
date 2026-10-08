const aws = @import("aws");
const std = @import("std");

const complete_rollout = @import("complete_rollout.zig");
const sample_ = @import("sample.zig");
const sample_with_response_stream = @import("sample_with_response_stream.zig");
const update_reward = @import("update_reward.zig");
const CallOptions = @import("call_options.zig").CallOptions;

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "SagemakerJobRuntime";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .options = options,
        };
    }

    pub fn deinit(self: *Self) void {
        _ = self;
    }

    /// Marks a rollout as complete, indicating that no further turns will be
    /// appended
    /// to the trajectory. After calling this operation, the trajectory is sealed
    /// and
    /// eligible for reward submission via the UpdateReward operation.
    pub fn completeRollout(self: *Self, allocator: std.mem.Allocator, input: complete_rollout.CompleteRolloutInput, options: CallOptions) !complete_rollout.CompleteRolloutOutput {
        return complete_rollout.execute(self, allocator, input, options);
    }

    /// Sends an inference request to the model during a job execution. The request
    /// and response bodies are forwarded to and from the model without
    /// modification.
    /// Each turn (prompt and response) is captured for later use.
    pub fn sample(self: *Self, allocator: std.mem.Allocator, input: sample_.SampleInput, options: CallOptions) !sample_.SampleOutput {
        return sample_.execute(self, allocator, input, options);
    }

    /// Sends a streaming inference request to the model during a job execution.
    /// Returns the response as a stream of payload chunks. Each turn is captured
    /// for later use.
    pub fn sampleWithResponseStream(self: *Self, allocator: std.mem.Allocator, input: sample_with_response_stream.SampleWithResponseStreamInput, options: CallOptions) !sample_with_response_stream.SampleWithResponseStreamOutput {
        return sample_with_response_stream.execute(self, allocator, input, options);
    }

    /// Updates the reward values for a trajectory and transitions it to
    /// reward-received status, signaling that it is eligible for processing. Call
    /// this
    /// operation after CompleteRollout to provide the computed reward scores.
    pub fn updateReward(self: *Self, allocator: std.mem.Allocator, input: update_reward.UpdateRewardInput, options: CallOptions) !update_reward.UpdateRewardOutput {
        return update_reward.execute(self, allocator, input, options);
    }
};

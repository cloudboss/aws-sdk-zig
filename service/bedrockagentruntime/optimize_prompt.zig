const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const InputPrompt = @import("input_prompt.zig").InputPrompt;
const OptimizedPromptStream = @import("optimized_prompt_stream.zig").OptimizedPromptStream;

pub const OptimizePromptInput = struct {
    /// Contains the prompt to optimize.
    input: InputPrompt,

    /// The unique identifier of the model that you want to optimize the prompt for.
    target_model_id: []const u8,

    pub const json_field_names = .{
        .input = "input",
        .target_model_id = "targetModelId",
    };
};

pub const OptimizePromptOutput = struct {
    /// The prompt after being optimized for the task.
    optimized_prompt: ?OptimizedPromptStream = null,

    pub const json_field_names = .{
        .optimized_prompt = "optimizedPrompt",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: OptimizePromptInput, options: Options) !OptimizePromptOutput {
    _ = client;
    _ = allocator;
    _ = input;
    _ = options;
    return error.EventStreamNotSupported;
}

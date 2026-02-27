const InputStatus = @import("input_status.zig").InputStatus;

/// Information about the input.
pub const InputSummary = struct {
    /// The time the input was created.
    creation_time: ?i64,

    /// The ARN of the input.
    input_arn: ?[]const u8,

    /// A brief description of the input.
    input_description: ?[]const u8,

    /// The name of the input.
    input_name: ?[]const u8,

    /// The last time the input was updated.
    last_update_time: ?i64,

    /// The status of the input.
    status: ?InputStatus,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .input_arn = "inputArn",
        .input_description = "inputDescription",
        .input_name = "inputName",
        .last_update_time = "lastUpdateTime",
        .status = "status",
    };
};

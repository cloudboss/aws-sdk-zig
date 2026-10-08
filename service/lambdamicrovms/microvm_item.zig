const MicrovmState = @import("microvm_state.zig").MicrovmState;

/// Contains summary information about a MicroVM instance.
pub const MicrovmItem = struct {
    /// The ARN of the MicroVM image used to run this MicroVM.
    image_arn: []const u8,

    /// The version of the MicroVM image used to run this MicroVM.
    image_version: []const u8,

    /// The unique identifier of the MicroVM.
    microvm_id: []const u8,

    /// The timestamp when the MicroVM started.
    started_at: i64,

    /// The current lifecycle state of the MicroVM.
    state: MicrovmState,

    pub const json_field_names = .{
        .image_arn = "imageArn",
        .image_version = "imageVersion",
        .microvm_id = "microvmId",
        .started_at = "startedAt",
        .state = "state",
    };
};

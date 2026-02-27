const InferenceReceiverMember = @import("inference_receiver_member.zig").InferenceReceiverMember;

/// Configuration information about how the inference output is stored.
pub const InferenceOutputConfiguration = struct {
    /// The MIME type used to specify the output data.
    accept: []const u8 = "application/json",

    /// Defines the members that can receive inference output.
    members: []const InferenceReceiverMember,

    pub const json_field_names = .{
        .accept = "accept",
        .members = "members",
    };
};

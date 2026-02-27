const TrainedModelExportReceiverMember = @import("trained_model_export_receiver_member.zig").TrainedModelExportReceiverMember;

/// Information about the output of the trained model export job.
pub const TrainedModelExportOutputConfiguration = struct {
    /// The members that will received the exported trained model output.
    members: []const TrainedModelExportReceiverMember,

    pub const json_field_names = .{
        .members = "members",
    };
};

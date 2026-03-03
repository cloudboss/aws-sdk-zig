/// Information about a pipeline's current status.
pub const PipelineStatusReason = struct {
    /// A description of why a pipeline has a certain status.
    description: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
    };
};

/// Contains information about the AI model involved in a finding.
pub const ModelDetail = struct {
    /// The identifier of the AI model.
    model_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .model_id = "ModelId",
    };
};

/// Contains information about a threat model that failed to delete.
pub const DeleteThreatModelFailure = struct {
    /// The reason the threat model failed to delete.
    reason: ?[]const u8 = null,

    /// The unique identifier of the threat model that failed to delete.
    threat_model_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .reason = "reason",
        .threat_model_id = "threatModelId",
    };
};

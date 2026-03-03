/// Represents an entry in a batch operation to update bill scenario commitment
/// modifications.
pub const BatchUpdateBillScenarioCommitmentModificationEntry = struct {
    /// The updated group identifier for the commitment modification.
    group: ?[]const u8 = null,

    /// The unique identifier of the commitment modification to update.
    id: []const u8,

    pub const json_field_names = .{
        .group = "group",
        .id = "id",
    };
};

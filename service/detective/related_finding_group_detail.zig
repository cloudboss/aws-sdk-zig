/// Details multiple activities as they related to a potential security event.
/// Detective uses graph analysis technique that infers relationships between
/// findings and entities, and groups them together as a finding group.
pub const RelatedFindingGroupDetail = struct {
    /// The unique identifier for the finding group.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "Id",
    };
};

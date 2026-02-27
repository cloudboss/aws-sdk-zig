/// The summary of the domain unit.
pub const DomainUnitSummary = struct {
    /// The ID of the domain unit summary.
    id: []const u8,

    /// The name of the domain unit summary.
    name: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
    };
};

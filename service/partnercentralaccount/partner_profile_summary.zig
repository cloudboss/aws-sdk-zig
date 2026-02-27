/// A summary view of a partner profile containing basic identifying
/// information.
pub const PartnerProfileSummary = struct {
    /// The unique identifier of the partner profile.
    id: []const u8,

    /// The display name of the partner.
    name: []const u8,

    pub const json_field_names = .{
        .id = "Id",
        .name = "Name",
    };
};

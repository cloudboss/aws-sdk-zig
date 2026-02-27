/// A businesschain is a chain of businesses that belong to the same brand. For
/// example `7-11`.
pub const BusinessChain = struct {
    /// The Business Chain Id.
    id: ?[]const u8,

    /// The business chain name.
    name: ?[]const u8,

    pub const json_field_names = .{
        .id = "Id",
        .name = "Name",
    };
};

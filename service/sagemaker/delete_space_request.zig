pub const DeleteSpaceRequest = struct {
    /// The ID of the associated domain.
    domain_id: []const u8,

    /// The name of the space.
    space_name: []const u8,

    pub const json_field_names = .{
        .domain_id = "DomainId",
        .space_name = "SpaceName",
    };
};

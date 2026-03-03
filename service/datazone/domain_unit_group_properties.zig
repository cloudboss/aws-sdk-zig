/// The properties of a domain unit group.
pub const DomainUnitGroupProperties = struct {
    /// The ID of the domain unit group.
    group_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .group_id = "groupId",
    };
};

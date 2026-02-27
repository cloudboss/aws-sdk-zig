/// The properties of the domain unit owners group.
pub const OwnerGroupProperties = struct {
    /// The ID of the domain unit owners group.
    group_identifier: []const u8,

    pub const json_field_names = .{
        .group_identifier = "groupIdentifier",
    };
};

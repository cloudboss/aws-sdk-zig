pub const StandbyWorkspaceRelationshipType = enum {
    primary,
    standby,

    pub const json_field_names = .{
        .primary = "PRIMARY",
        .standby = "STANDBY",
    };
};

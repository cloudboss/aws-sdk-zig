pub const RolesKeyIdCOption = enum {
    group_name,
    group_id,

    pub const json_field_names = .{
        .group_name = "GroupName",
        .group_id = "GroupId",
    };
};

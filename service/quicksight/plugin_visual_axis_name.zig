pub const PluginVisualAxisName = enum {
    group_by,
    value,

    pub const json_field_names = .{
        .group_by = "GROUP_BY",
        .value = "VALUE",
    };
};

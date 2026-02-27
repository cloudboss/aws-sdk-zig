pub const ChannelType = enum {
    single_master,
    full_mesh,

    pub const json_field_names = .{
        .single_master = "SINGLE_MASTER",
        .full_mesh = "FULL_MESH",
    };
};

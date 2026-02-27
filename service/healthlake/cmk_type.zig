pub const CmkType = enum {
    cm_cmk,
    ao_cmk,

    pub const json_field_names = .{
        .cm_cmk = "CM_CMK",
        .ao_cmk = "AO_CMK",
    };
};

pub const SmbSecurityDescriptorCopyFlags = enum {
    none,
    owner_dacl,
    owner_dacl_sacl,

    pub const json_field_names = .{
        .none = "NONE",
        .owner_dacl = "OWNER_DACL",
        .owner_dacl_sacl = "OWNER_DACL_SACL",
    };
};

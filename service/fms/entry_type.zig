pub const EntryType = enum {
    fms_managed_first_entry,
    fms_managed_last_entry,
    custom_entry,

    pub const json_field_names = .{
        .fms_managed_first_entry = "FMSManagedFirstEntry",
        .fms_managed_last_entry = "FMSManagedLastEntry",
        .custom_entry = "CustomEntry",
    };
};

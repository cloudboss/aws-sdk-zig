pub const IntendedUse = enum {
    /// Indicates that results of the operation are for single use, e.g., displaying
    /// results on a map or presenting options to users.
    single_use,
    /// Indicates that results of the operation may be stored locally.
    storage,

    pub const json_field_names = .{
        .single_use = "SingleUse",
        .storage = "Storage",
    };
};

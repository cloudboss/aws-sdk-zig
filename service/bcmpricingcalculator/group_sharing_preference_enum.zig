pub const GroupSharingPreferenceEnum = enum {
    open,
    prioritized,
    restricted,

    pub const json_field_names = .{
        .open = "OPEN",
        .prioritized = "PRIORITIZED",
        .restricted = "RESTRICTED",
    };
};

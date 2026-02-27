/// Describes a single version of a managed rule group.
pub const ManagedRuleGroupVersion = struct {
    /// The date and time that the managed rule group owner updated the rule group
    /// version
    /// information.
    last_update_timestamp: ?i64,

    /// The version name.
    name: ?[]const u8,

    pub const json_field_names = .{
        .last_update_timestamp = "LastUpdateTimestamp",
        .name = "Name",
    };
};

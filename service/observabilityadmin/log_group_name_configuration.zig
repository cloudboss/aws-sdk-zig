/// Configuration that specifies a naming pattern for destination log groups
/// created during centralization. The pattern supports static text and dynamic
/// variables that are replaced with source attributes when log groups are
/// created.
pub const LogGroupNameConfiguration = struct {
    /// The pattern used to generate destination log group names during
    /// centralization. The pattern can contain static text and dynamic variables
    /// that are replaced with source attributes. If a variable cannot be resolved,
    /// it inherits the value from its parent variable in the hierarchy. The pattern
    /// must be between 1 and 512 characters.
    ///
    /// Supported variables:
    ///
    /// * **${source.logGroup}** — The original log group name from the source
    ///   account.
    /// * **${source.accountId}** — The Amazon Web Services account ID where the log
    ///   originated.
    /// * **${source.region}** — The Amazon Web Services Region where the log
    ///   originated.
    /// * **${source.org.id}** — The Amazon Web Services Organization ID of the
    ///   source account.
    /// * **${source.org.ouId}** — The organizational unit ID of the source account.
    /// * **${source.org.rootId}** — The organization Root ID.
    /// * **${source.org.path}** — The organizational path from account to root.
    log_group_name_pattern: []const u8,

    pub const json_field_names = .{
        .log_group_name_pattern = "LogGroupNamePattern",
    };
};

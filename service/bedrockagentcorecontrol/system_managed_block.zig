/// System-managed metadata for rules created by automated processes such as A/B
/// tests.
pub const SystemManagedBlock = struct {
    /// The identifier of the system or process that manages this rule.
    managed_by: []const u8,

    pub const json_field_names = .{
        .managed_by = "managedBy",
    };
};

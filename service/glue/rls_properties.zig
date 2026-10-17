/// A structure that describes the default row-level security policy of a table.
pub const RLSProperties = struct {
    /// The name of the default row-level security policy applied to the table.
    default_rls_policy: ?[]const u8 = null,

    pub const json_field_names = .{
        .default_rls_policy = "DefaultRLSPolicy",
    };
};

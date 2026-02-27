const Principal = @import("principal.zig").Principal;

/// Information to define the hierarchy for which documents users should have
/// access to.
pub const HierarchicalPrincipal = struct {
    /// A list of
    /// [principal](https://docs.aws.amazon.com/kendra/latest/dg/API_Principal.html)
    /// lists that define the hierarchy for which documents users should
    /// have access to. Each hierarchical list specifies which user or group has
    /// allow or deny
    /// access for each document.
    principal_list: []const Principal,

    pub const json_field_names = .{
        .principal_list = "PrincipalList",
    };
};

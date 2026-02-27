/// Provides information about the column that should be used for filtering the
/// query
/// response by groups.
pub const AclConfiguration = struct {
    /// A list of groups, separated by semi-colons, that filters a query response
    /// based on
    /// user context. The document is only returned to users that are in one of the
    /// groups
    /// specified in the `UserContext` field of the `Query` API.
    allowed_groups_column_name: []const u8,

    pub const json_field_names = .{
        .allowed_groups_column_name = "AllowedGroupsColumnName",
    };
};

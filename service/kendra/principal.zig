const ReadAccessType = @import("read_access_type.zig").ReadAccessType;
const PrincipalType = @import("principal_type.zig").PrincipalType;

/// Provides user and group information for [user context
/// filtering](https://docs.aws.amazon.com/kendra/latest/dg/user-context-filter.html).
pub const Principal = struct {
    /// Whether to allow or deny document access to the principal.
    access: ReadAccessType,

    /// The identifier of the data source the principal should access documents
    /// from.
    data_source_id: ?[]const u8,

    /// The name of the user or group.
    name: []const u8,

    /// The type of principal.
    @"type": PrincipalType,

    pub const json_field_names = .{
        .access = "Access",
        .data_source_id = "DataSourceId",
        .name = "Name",
        .@"type" = "Type",
    };
};

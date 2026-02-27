const RowLevelPermissionFormatVersion = @import("row_level_permission_format_version.zig").RowLevelPermissionFormatVersion;
const RowLevelPermissionPolicy = @import("row_level_permission_policy.zig").RowLevelPermissionPolicy;
const Status = @import("status.zig").Status;

/// Information about a dataset that contains permissions for row-level security
/// (RLS).
/// The permissions dataset maps fields to users or groups. For more
/// information, see
/// [Using Row-Level Security (RLS) to Restrict Access to a
/// Dataset](https://docs.aws.amazon.com/quicksight/latest/user/restrict-access-to-a-data-set-using-row-level-security.html) in the *Quick Sight User
/// Guide*.
///
/// The option to deny permissions by setting `PermissionPolicy` to
/// `DENY_ACCESS` is
/// not supported for new RLS datasets.
pub const RowLevelPermissionDataSet = struct {
    /// The Amazon Resource Name (ARN) of the dataset that contains permissions for
    /// RLS.
    arn: []const u8,

    /// The user or group rules associated with the dataset that contains
    /// permissions for RLS.
    ///
    /// By default, `FormatVersion` is `VERSION_1`. When `FormatVersion` is
    /// `VERSION_1`, `UserName` and `GroupName` are required. When `FormatVersion`
    /// is `VERSION_2`, `UserARN` and `GroupARN` are required, and `Namespace` must
    /// not exist.
    format_version: ?RowLevelPermissionFormatVersion,

    /// The namespace associated with the dataset that contains permissions for RLS.
    namespace: ?[]const u8,

    /// The type of permissions to use when interpreting the permissions for RLS.
    /// `DENY_ACCESS`
    /// is included for backward compatibility only.
    permission_policy: RowLevelPermissionPolicy,

    /// The status of the row-level security permission dataset. If enabled, the
    /// status is `ENABLED`. If disabled, the status is `DISABLED`.
    status: ?Status,

    pub const json_field_names = .{
        .arn = "Arn",
        .format_version = "FormatVersion",
        .namespace = "Namespace",
        .permission_policy = "PermissionPolicy",
        .status = "Status",
    };
};

const ResourceStatus = @import("resource_status.zig").ResourceStatus;
const Status = @import("status.zig").Status;

/// An Amazon Web Services account within your environment that Amazon Inspector
/// has been enabled for.
pub const Account = struct {
    /// The ID of the Amazon Web Services account.
    account_id: []const u8,

    /// Details of the status of Amazon Inspector scans by resource type.
    resource_status: ResourceStatus,

    /// The status of Amazon Inspector for the account.
    status: Status,

    pub const json_field_names = .{
        .account_id = "accountId",
        .resource_status = "resourceStatus",
        .status = "status",
    };
};

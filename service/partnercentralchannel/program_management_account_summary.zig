const Program = @import("program.zig").Program;
const ProgramManagementAccountStatus = @import("program_management_account_status.zig").ProgramManagementAccountStatus;

/// Summary information about a program management account.
pub const ProgramManagementAccountSummary = struct {
    /// The AWS account ID associated with the program management account.
    account_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the program management account.
    arn: ?[]const u8 = null,

    /// The catalog identifier associated with the account.
    catalog: ?[]const u8 = null,

    /// The timestamp when the account was created.
    created_at: ?i64 = null,

    /// The display name of the program management account.
    display_name: ?[]const u8 = null,

    /// The unique identifier of the program management account.
    id: ?[]const u8 = null,

    /// The program type for the management account.
    program: ?Program = null,

    /// The current revision number of the program management account.
    revision: ?[]const u8 = null,

    /// The start date of the program management account.
    start_date: ?i64 = null,

    /// The current status of the program management account.
    status: ?ProgramManagementAccountStatus = null,

    /// The timestamp when the account was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .arn = "arn",
        .catalog = "catalog",
        .created_at = "createdAt",
        .display_name = "displayName",
        .id = "id",
        .program = "program",
        .revision = "revision",
        .start_date = "startDate",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

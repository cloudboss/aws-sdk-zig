const DedicatedTenancySupportResultEnum = @import("dedicated_tenancy_support_result_enum.zig").DedicatedTenancySupportResultEnum;
const DedicatedTenancyModificationStateEnum = @import("dedicated_tenancy_modification_state_enum.zig").DedicatedTenancyModificationStateEnum;

/// Describes a modification to the configuration of Bring Your Own License
/// (BYOL) for the
/// specified account.
pub const AccountModification = struct {
    /// The IP address range, specified as an IPv4 CIDR block, for the management
    /// network
    /// interface used for the account.
    dedicated_tenancy_management_cidr_range: ?[]const u8 = null,

    /// The status of BYOL (whether BYOL is being enabled or disabled).
    dedicated_tenancy_support: ?DedicatedTenancySupportResultEnum = null,

    /// The error code that is returned if the configuration of BYOL cannot be
    /// modified.
    error_code: ?[]const u8 = null,

    /// The text of the error message that is returned if the configuration of BYOL
    /// cannot be
    /// modified.
    error_message: ?[]const u8 = null,

    /// The state of the modification to the configuration of BYOL.
    modification_state: ?DedicatedTenancyModificationStateEnum = null,

    /// The timestamp when the modification of the BYOL configuration was started.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .dedicated_tenancy_management_cidr_range = "DedicatedTenancyManagementCidrRange",
        .dedicated_tenancy_support = "DedicatedTenancySupport",
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .modification_state = "ModificationState",
        .start_time = "StartTime",
    };
};

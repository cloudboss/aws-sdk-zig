const ManagementType = @import("management_type.zig").ManagementType;
const SecurityRequirementPackStatus = @import("security_requirement_pack_status.zig").SecurityRequirementPackStatus;

/// Filter criteria for listing security requirement packs.
pub const ListSecurityRequirementPackFilter = struct {
    /// Filter packs by management type. Valid values are AWS_MANAGED and
    /// CUSTOMER_MANAGED.
    management_type: ?ManagementType = null,

    /// Filter packs by status. Valid values are ENABLED and DISABLED.
    status: ?SecurityRequirementPackStatus = null,

    pub const json_field_names = .{
        .management_type = "managementType",
        .status = "status",
    };
};

const ManagementType = @import("management_type.zig").ManagementType;
const SecurityRequirementPackStatus = @import("security_requirement_pack_status.zig").SecurityRequirementPackStatus;

/// Contains summary information about a security requirement pack.
pub const SecurityRequirementPackSummary = struct {
    /// The date and time the security requirement pack was created, in UTC format.
    created_at: i64,

    /// A description of the security requirement pack.
    description: ?[]const u8 = null,

    /// The management type of the pack.
    management_type: ManagementType,

    /// The name of the security requirement pack.
    name: []const u8,

    /// The unique identifier of the security requirement pack.
    pack_id: []const u8,

    /// The status of the security requirement pack.
    status: SecurityRequirementPackStatus,

    /// The date and time the security requirement pack was last updated, in UTC
    /// format.
    updated_at: i64,

    /// The vendor name for AWS managed packs.
    vendor_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .management_type = "managementType",
        .name = "name",
        .pack_id = "packId",
        .status = "status",
        .updated_at = "updatedAt",
        .vendor_name = "vendorName",
    };
};

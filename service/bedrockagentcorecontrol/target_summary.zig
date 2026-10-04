const AuthorizationData = @import("authorization_data.zig").AuthorizationData;
const ListingMode = @import("listing_mode.zig").ListingMode;
const TargetStatus = @import("target_status.zig").TargetStatus;
const TargetType = @import("target_type.zig").TargetType;

/// Contains summary information about a gateway target. A target represents an
/// endpoint that the gateway can connect to.
pub const TargetSummary = struct {
    authorization_data: ?AuthorizationData = null,

    /// The timestamp when the target was created.
    created_at: i64,

    /// The description of the target.
    description: ?[]const u8 = null,

    /// The timestamp when the target was last synchronized.
    last_synchronized_at: ?i64 = null,

    /// The listing mode for the target. MCP resources for `DEFAULT` targets are
    /// cached at the control plane for faster access. MCP resources for `DYNAMIC`
    /// targets are retrieved dynamically when listing tools.
    listing_mode: ?ListingMode = null,

    /// The name of the target.
    name: []const u8,

    /// Priority for resolving resource URI conflicts across targets. Lower values
    /// take precedence. Defaults to 1000 when not set.
    resource_priority: ?i32 = null,

    /// The current status of the target.
    status: TargetStatus,

    /// The unique identifier of the target.
    target_id: []const u8,

    /// The type of the target.
    target_type: ?TargetType = null,

    /// The timestamp when the target was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .authorization_data = "authorizationData",
        .created_at = "createdAt",
        .description = "description",
        .last_synchronized_at = "lastSynchronizedAt",
        .listing_mode = "listingMode",
        .name = "name",
        .resource_priority = "resourcePriority",
        .status = "status",
        .target_id = "targetId",
        .target_type = "targetType",
        .updated_at = "updatedAt",
    };
};

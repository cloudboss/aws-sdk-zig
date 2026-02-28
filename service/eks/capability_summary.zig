const CapabilityStatus = @import("capability_status.zig").CapabilityStatus;
const CapabilityType = @import("capability_type.zig").CapabilityType;

/// A summary of a capability, containing basic information without the full
/// configuration details. This is returned by the `ListCapabilities` operation.
pub const CapabilitySummary = struct {
    /// The Amazon Resource Name (ARN) of the capability.
    arn: ?[]const u8,

    /// The unique name of the capability within the cluster.
    capability_name: ?[]const u8,

    /// The Unix epoch timestamp in seconds for when the capability was created.
    created_at: ?i64,

    /// The Unix epoch timestamp in seconds for when the capability was last
    /// modified.
    modified_at: ?i64,

    /// The current status of the capability.
    status: ?CapabilityStatus,

    /// The type of capability. Valid values are `ACK`, `ARGOCD`, or `KRO`.
    type: ?CapabilityType,

    /// The version of the capability software that is currently running.
    version: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .capability_name = "capabilityName",
        .created_at = "createdAt",
        .modified_at = "modifiedAt",
        .status = "status",
        .type = "type",
        .version = "version",
    };
};

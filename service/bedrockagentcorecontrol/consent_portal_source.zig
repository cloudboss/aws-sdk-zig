const ConsentPortalSourceType = @import("consent_portal_source_type.zig").ConsentPortalSourceType;

/// A resource served by the consent portal.
pub const ConsentPortalSource = struct {
    /// The identifier of the source resource. For an `agentcore-gateway` source,
    /// this is the gateway ID or its Amazon Resource Name (ARN).
    identifier: []const u8,

    /// The type of the source resource.
    type: ConsentPortalSourceType,

    pub const json_field_names = .{
        .identifier = "identifier",
        .type = "type",
    };
};

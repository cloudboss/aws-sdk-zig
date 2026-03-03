const ResolverAutodefinedReverseStatus = @import("resolver_autodefined_reverse_status.zig").ResolverAutodefinedReverseStatus;

/// A complex type that contains information about a Resolver configuration for
/// a VPC.
pub const ResolverConfig = struct {
    /// The status of whether or not the Resolver will create autodefined rules for
    /// reverse DNS
    /// lookups. This is enabled by default. The status can be one of following:
    ///
    /// * **ENABLING:** Autodefined rules for reverse DNS lookups are being
    /// enabled but are not complete.
    ///
    /// * **ENABLED:** Autodefined rules for reverse DNS lookups are
    /// enabled.
    ///
    /// * **DISABLING:** Autodefined rules for reverse DNS lookups are
    /// being disabled but are not complete.
    ///
    /// * **DISABLED:** Autodefined rules for reverse DNS lookups are
    /// disabled.
    autodefined_reverse: ?ResolverAutodefinedReverseStatus = null,

    /// ID for the Resolver configuration.
    id: ?[]const u8 = null,

    /// The owner account ID of the Amazon Virtual Private Cloud VPC.
    owner_id: ?[]const u8 = null,

    /// The ID of the Amazon Virtual Private Cloud VPC or a Route 53 Profile that
    /// you're configuring Resolver for.
    resource_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .autodefined_reverse = "AutodefinedReverse",
        .id = "Id",
        .owner_id = "OwnerId",
        .resource_id = "ResourceId",
    };
};

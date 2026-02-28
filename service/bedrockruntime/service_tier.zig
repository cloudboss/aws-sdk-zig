const ServiceTierType = @import("service_tier_type.zig").ServiceTierType;

/// Specifies the processing tier configuration used for serving the request.
pub const ServiceTier = struct {
    /// Specifies the processing tier type used for serving the request.
    @"type": ServiceTierType,

    pub const json_field_names = .{
        .@"type" = "type",
    };
};

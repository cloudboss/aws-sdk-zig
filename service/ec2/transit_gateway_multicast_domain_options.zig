const AutoAcceptSharedAssociationsValue = @import("auto_accept_shared_associations_value.zig").AutoAcceptSharedAssociationsValue;
const Igmpv2SupportValue = @import("igmpv_2_support_value.zig").Igmpv2SupportValue;
const StaticSourcesSupportValue = @import("static_sources_support_value.zig").StaticSourcesSupportValue;

/// Describes the options for a transit gateway multicast domain.
pub const TransitGatewayMulticastDomainOptions = struct {
    /// Indicates whether to automatically cross-account subnet associations that
    /// are associated with the transit gateway multicast domain.
    auto_accept_shared_associations: ?AutoAcceptSharedAssociationsValue,

    /// Indicates whether Internet Group Management Protocol (IGMP) version 2 is
    /// turned on for the transit gateway multicast domain.
    igmpv_2_support: ?Igmpv2SupportValue,

    /// Indicates whether support for statically configuring transit gateway
    /// multicast group sources is turned on.
    static_sources_support: ?StaticSourcesSupportValue,
};

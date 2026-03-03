const AutoAcceptSharedAssociationsValue = @import("auto_accept_shared_associations_value.zig").AutoAcceptSharedAssociationsValue;
const Igmpv2SupportValue = @import("igmpv_2_support_value.zig").Igmpv2SupportValue;
const StaticSourcesSupportValue = @import("static_sources_support_value.zig").StaticSourcesSupportValue;

/// The options for the transit gateway multicast domain.
pub const CreateTransitGatewayMulticastDomainRequestOptions = struct {
    /// Indicates whether to automatically accept cross-account subnet associations
    /// that are associated with the transit gateway multicast domain.
    auto_accept_shared_associations: ?AutoAcceptSharedAssociationsValue = null,

    /// Specify whether to enable Internet Group Management Protocol (IGMP) version
    /// 2 for the transit gateway multicast domain.
    igmpv_2_support: ?Igmpv2SupportValue = null,

    /// Specify whether to enable support for statically configuring multicast group
    /// sources for a domain.
    static_sources_support: ?StaticSourcesSupportValue = null,
};

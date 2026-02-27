const EgressFilterType = @import("egress_filter_type.zig").EgressFilterType;

/// An object that represents the egress filter rules for a service mesh.
pub const EgressFilter = struct {
    /// The egress filter type. By default, the type is `DROP_ALL`, which allows
    /// egress only from virtual nodes to other defined resources in the service
    /// mesh (and any
    /// traffic to `*.amazonaws.com` for Amazon Web Services API calls). You can set
    /// the
    /// egress filter type to `ALLOW_ALL` to allow egress to any endpoint inside or
    /// outside of the service mesh.
    type: EgressFilterType,

    pub const json_field_names = .{
        .type = "type",
    };
};

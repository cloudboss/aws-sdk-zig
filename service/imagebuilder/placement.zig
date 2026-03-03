const TenancyType = @import("tenancy_type.zig").TenancyType;

/// By default, EC2 instances run on shared tenancy hardware. This means that
/// multiple
/// Amazon Web Services accounts might share the same physical hardware. When
/// you use dedicated hardware,
/// the physical server that hosts your instances is dedicated to your Amazon
/// Web Services account.
/// Instance placement settings contain the details for the physical hardware
/// where
/// instances that Image Builder launches during image creation will run.
pub const Placement = struct {
    /// The Availability Zone where your build and test instances will launch.
    availability_zone: ?[]const u8 = null,

    /// The ID of the Dedicated Host on which build and test instances run. This
    /// only
    /// applies if `tenancy` is `host`. If you specify the host ID, you
    /// must not specify the resource group ARN. If you specify both, Image Builder
    /// returns an error.
    host_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the host resource group in which to launch
    /// build and test instances.
    /// This only applies if `tenancy` is `host`. If you specify the resource
    /// group ARN, you must not specify the host ID. If you specify both, Image
    /// Builder returns an error.
    host_resource_group_arn: ?[]const u8 = null,

    /// The tenancy of the instance. An instance with a tenancy of `dedicated`
    /// runs on single-tenant hardware. An instance with a tenancy of `host` runs
    /// on a Dedicated Host.
    ///
    /// If tenancy is set to `host`, then you can optionally specify one target
    /// for placement – either host ID or host resource group ARN. If automatic
    /// placement
    /// is enabled for your host, and you don't specify any placement target, Amazon
    /// EC2 will try to
    /// find an available host for your build and test instances.
    tenancy: ?TenancyType = null,

    pub const json_field_names = .{
        .availability_zone = "availabilityZone",
        .host_id = "hostId",
        .host_resource_group_arn = "hostResourceGroupArn",
        .tenancy = "tenancy",
    };
};

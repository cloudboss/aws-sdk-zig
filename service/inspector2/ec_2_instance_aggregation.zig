const StringFilter = @import("string_filter.zig").StringFilter;
const MapFilter = @import("map_filter.zig").MapFilter;
const Ec2InstanceSortBy = @import("ec_2_instance_sort_by.zig").Ec2InstanceSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;

/// The details that define an aggregation based on Amazon EC2 instances.
pub const Ec2InstanceAggregation = struct {
    /// The AMI IDs associated with the Amazon EC2 instances to aggregate findings
    /// for.
    amis: ?[]const StringFilter = null,

    /// The Amazon EC2 instance IDs to aggregate findings for.
    instance_ids: ?[]const StringFilter = null,

    /// The Amazon EC2 instance tags to aggregate findings for.
    instance_tags: ?[]const MapFilter = null,

    /// The operating system types to aggregate findings for. Valid values must be
    /// uppercase and
    /// underscore separated, examples are `ORACLE_LINUX_7` and
    /// `ALPINE_LINUX_3_8`.
    operating_systems: ?[]const StringFilter = null,

    /// The value to sort results by.
    sort_by: ?Ec2InstanceSortBy = null,

    /// The order to sort results by.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .amis = "amis",
        .instance_ids = "instanceIds",
        .instance_tags = "instanceTags",
        .operating_systems = "operatingSystems",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};

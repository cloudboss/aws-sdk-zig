const InstanceIdFilter = @import("instance_id_filter.zig").InstanceIdFilter;

/// Filter model by type
pub const CampaignFilters = struct {
    instance_id_filter: ?InstanceIdFilter,

    pub const json_field_names = .{
        .instance_id_filter = "instanceIdFilter",
    };
};

pub const LifecycleManagementStrategy = enum {
    unknown,
    per_worker,
    by_spatial_subdivision,
    by_request,

    pub const json_field_names = .{
        .unknown = "Unknown",
        .per_worker = "PerWorker",
        .by_spatial_subdivision = "BySpatialSubdivision",
        .by_request = "ByRequest",
    };
};

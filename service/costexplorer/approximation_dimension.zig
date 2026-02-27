pub const ApproximationDimension = enum {
    service,
    resource,

    pub const json_field_names = .{
        .service = "SERVICE",
        .resource = "RESOURCE",
    };
};

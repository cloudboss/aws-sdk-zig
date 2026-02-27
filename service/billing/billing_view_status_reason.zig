pub const BillingViewStatusReason = enum {
    source_view_unhealthy,
    source_view_updating,
    source_view_access_denied,
    source_view_not_found,
    cyclic_dependency,
    source_view_depth_exceeded,
    aggregate_source,
    view_owner_not_management_account,

    pub const json_field_names = .{
        .source_view_unhealthy = "SOURCE_VIEW_UNHEALTHY",
        .source_view_updating = "SOURCE_VIEW_UPDATING",
        .source_view_access_denied = "SOURCE_VIEW_ACCESS_DENIED",
        .source_view_not_found = "SOURCE_VIEW_NOT_FOUND",
        .cyclic_dependency = "CYCLIC_DEPENDENCY",
        .source_view_depth_exceeded = "SOURCE_VIEW_DEPTH_EXCEEDED",
        .aggregate_source = "AGGREGATE_SOURCE",
        .view_owner_not_management_account = "VIEW_OWNER_NOT_MANAGEMENT_ACCOUNT",
    };
};

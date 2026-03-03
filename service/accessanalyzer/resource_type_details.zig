/// Contains information about the total number of active cross-account and
/// public findings for a resource type of an external access analyzer.
pub const ResourceTypeDetails = struct {
    /// The total number of active cross-account findings for the resource type.
    total_active_cross_account: ?i32 = null,

    /// The total number of active errors for the resource type.
    total_active_errors: ?i32 = null,

    /// The total number of active public findings for the resource type.
    total_active_public: ?i32 = null,

    pub const json_field_names = .{
        .total_active_cross_account = "totalActiveCrossAccount",
        .total_active_errors = "totalActiveErrors",
        .total_active_public = "totalActivePublic",
    };
};

pub const ResourceNotFoundExceptionReason = enum {
    snapshot_not_found,
    grant_not_found,
    dependency_resource_not_found,
    image_not_found,

    pub const json_field_names = .{
        .snapshot_not_found = "SNAPSHOT_NOT_FOUND",
        .grant_not_found = "GRANT_NOT_FOUND",
        .dependency_resource_not_found = "DEPENDENCY_RESOURCE_NOT_FOUND",
        .image_not_found = "IMAGE_NOT_FOUND",
    };
};

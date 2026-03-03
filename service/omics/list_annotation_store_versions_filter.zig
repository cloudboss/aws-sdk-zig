const VersionStatus = @import("version_status.zig").VersionStatus;

/// Use filters to focus the returned annotation store versions on a specific
/// parameter, such as the status of the annotation store.
pub const ListAnnotationStoreVersionsFilter = struct {
    /// The status of an annotation store version.
    status: ?VersionStatus = null,

    pub const json_field_names = .{
        .status = "status",
    };
};

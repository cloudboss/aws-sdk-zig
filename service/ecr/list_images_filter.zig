const ImageStatusFilter = @import("image_status_filter.zig").ImageStatusFilter;
const TagStatus = @import("tag_status.zig").TagStatus;

/// An object representing a filter on a ListImages operation.
pub const ListImagesFilter = struct {
    /// The image status with which to filter your ListImages results.
    /// Valid values are `ACTIVE`, `ARCHIVED`, and `ACTIVATING`.
    /// If not specified, only images with `ACTIVE` status are returned.
    image_status: ?ImageStatusFilter = null,

    /// The tag status with which to filter your ListImages results.
    tag_status: ?TagStatus = null,

    pub const json_field_names = .{
        .image_status = "imageStatus",
        .tag_status = "tagStatus",
    };
};

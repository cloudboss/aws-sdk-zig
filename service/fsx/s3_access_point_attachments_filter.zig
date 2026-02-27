const S3AccessPointAttachmentsFilterName = @import("s3_access_point_attachments_filter_name.zig").S3AccessPointAttachmentsFilterName;

/// A set of Name and Values pairs used to view a select set of S3 access point
/// attachments.
pub const S3AccessPointAttachmentsFilter = struct {
    /// The name of the filter.
    name: ?S3AccessPointAttachmentsFilterName,

    /// The values of the filter.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};

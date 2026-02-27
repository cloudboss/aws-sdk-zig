const GenericRevisionInfo = @import("generic_revision_info.zig").GenericRevisionInfo;
const RevisionLocation = @import("revision_location.zig").RevisionLocation;

/// Information about an application revision.
pub const RevisionInfo = struct {
    /// Information about an application revision, including usage details and
    /// associated
    /// deployment groups.
    generic_revision_info: ?GenericRevisionInfo,

    /// Information about the location and type of an application revision.
    revision_location: ?RevisionLocation,

    pub const json_field_names = .{
        .generic_revision_info = "genericRevisionInfo",
        .revision_location = "revisionLocation",
    };
};

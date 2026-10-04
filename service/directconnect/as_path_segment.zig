const AsPathType = @import("as_path_type.zig").AsPathType;

/// A segment of an autonomous system (AS) path.
pub const AsPathSegment = struct {
    /// The autonomous system (AS) numbers in the segment.
    path: ?[]const i64 = null,

    /// The type of the AS path segment.
    ///
    /// The valid values are `seq` (an ordered `AS_SEQUENCE`) and `set` (an
    /// unordered `AS_SET`).
    path_type: ?AsPathType = null,

    pub const json_field_names = .{
        .path = "path",
        .path_type = "pathType",
    };
};

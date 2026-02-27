const ArchiveFilterCondition = @import("archive_filter_condition.zig").ArchiveFilterCondition;

/// A set of filter conditions to include and/or exclude emails.
pub const ArchiveFilters = struct {
    /// The filter conditions for emails to include.
    include: ?[]const ArchiveFilterCondition,

    /// The filter conditions for emails to exclude.
    unless: ?[]const ArchiveFilterCondition,

    pub const json_field_names = .{
        .include = "Include",
        .unless = "Unless",
    };
};

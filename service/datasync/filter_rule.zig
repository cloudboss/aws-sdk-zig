const FilterType = @import("filter_type.zig").FilterType;

/// Specifies which files, folders, and objects to include or exclude when
/// transferring files
/// from source to destination.
pub const FilterRule = struct {
    /// The type of filter rule to apply. DataSync only supports the SIMPLE_PATTERN
    /// rule type.
    filter_type: ?FilterType,

    /// A single filter string that consists of the patterns to include or exclude.
    /// The patterns
    /// are delimited by "|" (that is, a pipe), for example: `/folder1|/folder2`
    value: ?[]const u8,

    pub const json_field_names = .{
        .filter_type = "FilterType",
        .value = "Value",
    };
};

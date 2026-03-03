const TimeCondition = @import("time_condition.zig").TimeCondition;
const StringCondition = @import("string_condition.zig").StringCondition;
const LongCondition = @import("long_condition.zig").LongCondition;

/// This contains arrays of objects, which may include CreationTimes time
/// condition objects, FilePaths string objects, LastModificationTimes time
/// condition objects,
pub const EBSItemFilter = struct {
    /// You can include 1 to 10 values.
    ///
    /// If one is included, the results will return only items that match.
    ///
    /// If more than one is included, the results will return all items that match
    /// any of the included values.
    creation_times: ?[]const TimeCondition = null,

    /// You can include 1 to 10 values.
    ///
    /// If one file path is included, the results will return only items that match
    /// the file path.
    ///
    /// If more than one file path is included, the results will return all items
    /// that match any of the file paths.
    file_paths: ?[]const StringCondition = null,

    /// You can include 1 to 10 values.
    ///
    /// If one is included, the results will return only items that match.
    ///
    /// If more than one is included, the results will return all items that match
    /// any of the included values.
    last_modification_times: ?[]const TimeCondition = null,

    /// You can include 1 to 10 values.
    ///
    /// If one is included, the results will return only items that match.
    ///
    /// If more than one is included, the results will return all items that match
    /// any of the included values.
    sizes: ?[]const LongCondition = null,

    pub const json_field_names = .{
        .creation_times = "CreationTimes",
        .file_paths = "FilePaths",
        .last_modification_times = "LastModificationTimes",
        .sizes = "Sizes",
    };
};

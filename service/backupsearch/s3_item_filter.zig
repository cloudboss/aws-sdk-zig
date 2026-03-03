const TimeCondition = @import("time_condition.zig").TimeCondition;
const StringCondition = @import("string_condition.zig").StringCondition;
const LongCondition = @import("long_condition.zig").LongCondition;

/// This contains arrays of objects, which may include ObjectKeys, Sizes,
/// CreationTimes, VersionIds, and/or Etags.
pub const S3ItemFilter = struct {
    /// You can include 1 to 10 values.
    ///
    /// If one value is included, the results will return only items that match the
    /// value.
    ///
    /// If more than one value is included, the results will return all items that
    /// match any of the values.
    creation_times: ?[]const TimeCondition = null,

    /// You can include 1 to 10 values.
    ///
    /// If one value is included, the results will return only items that match the
    /// value.
    ///
    /// If more than one value is included, the results will return all items that
    /// match any of the values.
    e_tags: ?[]const StringCondition = null,

    /// You can include 1 to 10 values.
    ///
    /// If one value is included, the results will return only items that match the
    /// value.
    ///
    /// If more than one value is included, the results will return all items that
    /// match any of the values.
    object_keys: ?[]const StringCondition = null,

    /// You can include 1 to 10 values.
    ///
    /// If one value is included, the results will return only items that match the
    /// value.
    ///
    /// If more than one value is included, the results will return all items that
    /// match any of the values.
    sizes: ?[]const LongCondition = null,

    /// You can include 1 to 10 values.
    ///
    /// If one value is included, the results will return only items that match the
    /// value.
    ///
    /// If more than one value is included, the results will return all items that
    /// match any of the values.
    version_ids: ?[]const StringCondition = null,

    pub const json_field_names = .{
        .creation_times = "CreationTimes",
        .e_tags = "ETags",
        .object_keys = "ObjectKeys",
        .sizes = "Sizes",
        .version_ids = "VersionIds",
    };
};

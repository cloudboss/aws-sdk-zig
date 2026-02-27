/// The number of files or objects that DataSync finds at your locations.
///
/// Applies only to [Enhanced mode
/// tasks](https://docs.aws.amazon.com/datasync/latest/userguide/choosing-task-mode.html).
pub const TaskExecutionFilesListedDetail = struct {
    /// The number of files or objects that DataSync finds at your destination
    /// location. This
    /// counter is only applicable if you [configure your
    /// task](https://docs.aws.amazon.com/datasync/latest/userguide/configure-metadata.html#task-option-file-object-handling) to delete data in the destination that isn't in the
    /// source.
    at_destination_for_delete: i64 = 0,

    /// The number of files or objects that DataSync finds at your source location.
    ///
    /// * With a
    ///   [manifest](https://docs.aws.amazon.com/datasync/latest/userguide/transferring-with-manifest.html), DataSync
    /// lists only what's in your manifest (and not everything at your source
    /// location).
    ///
    /// * With an include
    ///   [filter](https://docs.aws.amazon.com/datasync/latest/userguide/filtering.html), DataSync lists only what
    /// matches the filter at your source location.
    ///
    /// * With an exclude filter, DataSync lists everything at your source location
    ///   before applying
    /// the filter.
    at_source: i64 = 0,

    pub const json_field_names = .{
        .at_destination_for_delete = "AtDestinationForDelete",
        .at_source = "AtSource",
    };
};

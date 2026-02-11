const ExportViewType = @import("export_view_type.zig").ExportViewType;

/// Optional object containing the parameters specific to an incremental export.
pub const IncrementalExportSpecification = struct {
    /// Time in the past which provides the inclusive start range for the export
    /// table's data,
    /// counted in seconds from the start of the Unix epoch. The incremental export
    /// will reflect
    /// the table's state including and after this point in time.
    export_from_time: ?i64,

    /// Time in the past which provides the exclusive end range for the export
    /// table's data,
    /// counted in seconds from the start of the Unix epoch. The incremental export
    /// will reflect
    /// the table's state just prior to this point in time. If this is not provided,
    /// the latest
    /// time with data available will be used.
    export_to_time: ?i64,

    /// The view type that was chosen for the export. Valid values are
    /// `NEW_AND_OLD_IMAGES` and `NEW_IMAGES`. The default value is
    /// `NEW_AND_OLD_IMAGES`.
    export_view_type: ?ExportViewType,

    pub const json_field_names = .{
        .export_from_time = "ExportFromTime",
        .export_to_time = "ExportToTime",
        .export_view_type = "ExportViewType",
    };
};

const ProcessedObject = @import("processed_object.zig").ProcessedObject;

/// Provides information about the progress of the schema conversion operation.
pub const Progress = struct {
    /// The name of the database object that the schema conversion operation
    /// currently uses.
    processed_object: ?ProcessedObject = null,

    /// The percent complete for the current step of the schema conversion
    /// operation.
    progress_percent: ?f64 = null,

    /// The step of the schema conversion operation. This parameter can store one of
    /// the following values:
    ///
    /// * `IN_PROGRESS` – The operation is running.
    ///
    /// * `LOADING_METADATA` – Loads metadata from the source database.
    ///
    /// * `COUNTING_OBJECTS` – Determines the number of objects involved
    /// in the operation.
    ///
    /// * `ANALYZING` – Analyzes the source database objects.
    ///
    /// * `CONVERTING` – Converts the source database objects to a format compatible
    /// with the target database.
    ///
    /// * `APPLYING` – Applies the converted code to the target database.
    ///
    /// * `FINISHED` – The operation completed successfully.
    progress_step: ?[]const u8 = null,

    /// The number of objects in this schema conversion operation.
    total_objects: i64 = 0,

    pub const json_field_names = .{
        .processed_object = "ProcessedObject",
        .progress_percent = "ProgressPercent",
        .progress_step = "ProgressStep",
        .total_objects = "TotalObjects",
    };
};

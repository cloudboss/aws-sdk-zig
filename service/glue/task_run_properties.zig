const ExportLabelsTaskRunProperties = @import("export_labels_task_run_properties.zig").ExportLabelsTaskRunProperties;
const FindMatchesTaskRunProperties = @import("find_matches_task_run_properties.zig").FindMatchesTaskRunProperties;
const ImportLabelsTaskRunProperties = @import("import_labels_task_run_properties.zig").ImportLabelsTaskRunProperties;
const LabelingSetGenerationTaskRunProperties = @import("labeling_set_generation_task_run_properties.zig").LabelingSetGenerationTaskRunProperties;
const TaskType = @import("task_type.zig").TaskType;

/// The configuration properties for the task run.
pub const TaskRunProperties = struct {
    /// The configuration properties for an exporting labels task run.
    export_labels_task_run_properties: ?ExportLabelsTaskRunProperties = null,

    /// The configuration properties for a find matches task run.
    find_matches_task_run_properties: ?FindMatchesTaskRunProperties = null,

    /// The configuration properties for an importing labels task run.
    import_labels_task_run_properties: ?ImportLabelsTaskRunProperties = null,

    /// The configuration properties for a labeling set generation task run.
    labeling_set_generation_task_run_properties: ?LabelingSetGenerationTaskRunProperties = null,

    /// The type of task run.
    task_type: ?TaskType = null,

    pub const json_field_names = .{
        .export_labels_task_run_properties = "ExportLabelsTaskRunProperties",
        .find_matches_task_run_properties = "FindMatchesTaskRunProperties",
        .import_labels_task_run_properties = "ImportLabelsTaskRunProperties",
        .labeling_set_generation_task_run_properties = "LabelingSetGenerationTaskRunProperties",
        .task_type = "TaskType",
    };
};

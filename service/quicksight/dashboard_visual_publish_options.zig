const ExportHiddenFieldsOption = @import("export_hidden_fields_option.zig").ExportHiddenFieldsOption;

/// The visual publish options of a visual in a dashboard
pub const DashboardVisualPublishOptions = struct {
    /// Determines if hidden fields are included in an exported dashboard.
    export_hidden_fields_option: ?ExportHiddenFieldsOption,

    pub const json_field_names = .{
        .export_hidden_fields_option = "ExportHiddenFieldsOption",
    };
};

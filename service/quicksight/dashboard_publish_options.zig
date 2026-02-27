const AdHocFilteringOption = @import("ad_hoc_filtering_option.zig").AdHocFilteringOption;
const DataPointDrillUpDownOption = @import("data_point_drill_up_down_option.zig").DataPointDrillUpDownOption;
const DataPointMenuLabelOption = @import("data_point_menu_label_option.zig").DataPointMenuLabelOption;
const DataPointTooltipOption = @import("data_point_tooltip_option.zig").DataPointTooltipOption;
const DataQAEnabledOption = @import("data_qa_enabled_option.zig").DataQAEnabledOption;
const DataStoriesSharingOption = @import("data_stories_sharing_option.zig").DataStoriesSharingOption;
const ExecutiveSummaryOption = @import("executive_summary_option.zig").ExecutiveSummaryOption;
const ExportToCSVOption = @import("export_to_csv_option.zig").ExportToCSVOption;
const ExportWithHiddenFieldsOption = @import("export_with_hidden_fields_option.zig").ExportWithHiddenFieldsOption;
const QuickSuiteActionsOption = @import("quick_suite_actions_option.zig").QuickSuiteActionsOption;
const SheetControlsOption = @import("sheet_controls_option.zig").SheetControlsOption;
const SheetLayoutElementMaximizationOption = @import("sheet_layout_element_maximization_option.zig").SheetLayoutElementMaximizationOption;
const VisualAxisSortOption = @import("visual_axis_sort_option.zig").VisualAxisSortOption;
const VisualMenuOption = @import("visual_menu_option.zig").VisualMenuOption;
const DashboardVisualPublishOptions = @import("dashboard_visual_publish_options.zig").DashboardVisualPublishOptions;

/// Dashboard publish options.
pub const DashboardPublishOptions = struct {
    /// Ad hoc (one-time) filtering option.
    ad_hoc_filtering_option: ?AdHocFilteringOption,

    /// The drill-down options of data points in a dashboard.
    data_point_drill_up_down_option: ?DataPointDrillUpDownOption,

    /// The data point menu label options of a dashboard.
    data_point_menu_label_option: ?DataPointMenuLabelOption,

    /// The data point tool tip options of a dashboard.
    data_point_tooltip_option: ?DataPointTooltipOption,

    /// Adds Q&A capabilities to an Quick Sight dashboard. If no topic is linked,
    /// Dashboard Q&A uses the data values that are rendered on the dashboard. End
    /// users can use Dashboard Q&A to ask for different slices of the data that
    /// they see on the dashboard. If a topic is linked, Topic Q&A is used.
    data_qa_enabled_option: ?DataQAEnabledOption,

    /// Data stories sharing option.
    data_stories_sharing_option: ?DataStoriesSharingOption,

    /// Executive summary option.
    executive_summary_option: ?ExecutiveSummaryOption,

    /// Export to .csv option.
    export_to_csv_option: ?ExportToCSVOption,

    /// Determines if hidden fields are exported with a dashboard.
    export_with_hidden_fields_option: ?ExportWithHiddenFieldsOption,

    /// Determines if Actions in Amazon Quick Suite are enabled in a dashboard.
    quick_suite_actions_option: ?QuickSuiteActionsOption,

    /// Sheet controls option.
    sheet_controls_option: ?SheetControlsOption,

    /// The sheet layout maximization options of a dashbaord.
    sheet_layout_element_maximization_option: ?SheetLayoutElementMaximizationOption,

    /// The axis sort options of a dashboard.
    visual_axis_sort_option: ?VisualAxisSortOption,

    /// The menu options of a visual in a dashboard.
    visual_menu_option: ?VisualMenuOption,

    /// The visual publish options of a visual in a dashboard.
    visual_publish_options: ?DashboardVisualPublishOptions,

    pub const json_field_names = .{
        .ad_hoc_filtering_option = "AdHocFilteringOption",
        .data_point_drill_up_down_option = "DataPointDrillUpDownOption",
        .data_point_menu_label_option = "DataPointMenuLabelOption",
        .data_point_tooltip_option = "DataPointTooltipOption",
        .data_qa_enabled_option = "DataQAEnabledOption",
        .data_stories_sharing_option = "DataStoriesSharingOption",
        .executive_summary_option = "ExecutiveSummaryOption",
        .export_to_csv_option = "ExportToCSVOption",
        .export_with_hidden_fields_option = "ExportWithHiddenFieldsOption",
        .quick_suite_actions_option = "QuickSuiteActionsOption",
        .sheet_controls_option = "SheetControlsOption",
        .sheet_layout_element_maximization_option = "SheetLayoutElementMaximizationOption",
        .visual_axis_sort_option = "VisualAxisSortOption",
        .visual_menu_option = "VisualMenuOption",
        .visual_publish_options = "VisualPublishOptions",
    };
};

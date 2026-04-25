const AnalysisDefaults = @import("analysis_defaults.zig").AnalysisDefaults;
const CalculatedField = @import("calculated_field.zig").CalculatedField;
const ColumnConfiguration = @import("column_configuration.zig").ColumnConfiguration;
const DataSetConfiguration = @import("data_set_configuration.zig").DataSetConfiguration;
const FilterGroup = @import("filter_group.zig").FilterGroup;
const AssetOptions = @import("asset_options.zig").AssetOptions;
const ParameterDeclaration = @import("parameter_declaration.zig").ParameterDeclaration;
const QueryExecutionOptions = @import("query_execution_options.zig").QueryExecutionOptions;
const SheetDefinition = @import("sheet_definition.zig").SheetDefinition;
const StaticFile = @import("static_file.zig").StaticFile;
const TooltipSheetDefinition = @import("tooltip_sheet_definition.zig").TooltipSheetDefinition;

/// The detailed definition of a template.
pub const TemplateVersionDefinition = struct {
    analysis_defaults: ?AnalysisDefaults = null,

    /// An array of calculated field definitions for the template.
    calculated_fields: ?[]const CalculatedField = null,

    /// An array of template-level column
    /// configurations. Column configurations are used to set default formatting for
    /// a column that's used throughout a template.
    column_configurations: ?[]const ColumnConfiguration = null,

    /// An array of dataset configurations. These configurations define the required
    /// columns for each dataset used within a template.
    data_set_configurations: []const DataSetConfiguration,

    /// Filter definitions for a template.
    ///
    /// For more information, see [Filtering
    /// Data](https://docs.aws.amazon.com/quicksight/latest/user/filtering-visual-data.html) in the *Amazon Quick Suite User Guide*.
    filter_groups: ?[]const FilterGroup = null,

    /// An array of option definitions for a template.
    options: ?AssetOptions = null,

    /// An array of parameter declarations for a template.
    ///
    /// *Parameters* are named variables that can transfer a value for use by an
    /// action or an object.
    ///
    /// For more information, see [Parameters in Amazon Quick
    /// Sight](https://docs.aws.amazon.com/quicksight/latest/user/parameters-in-quicksight.html) in the
    /// *Amazon Quick Suite User Guide*.
    parameter_declarations: ?[]const ParameterDeclaration = null,

    query_execution_options: ?QueryExecutionOptions = null,

    /// An array of sheet definitions for a template.
    sheets: ?[]const SheetDefinition = null,

    /// The static files for the definition.
    static_files: ?[]const StaticFile = null,

    /// An array of tooltip sheet definitions for a template.
    tooltip_sheets: ?[]const TooltipSheetDefinition = null,

    pub const json_field_names = .{
        .analysis_defaults = "AnalysisDefaults",
        .calculated_fields = "CalculatedFields",
        .column_configurations = "ColumnConfigurations",
        .data_set_configurations = "DataSetConfigurations",
        .filter_groups = "FilterGroups",
        .options = "Options",
        .parameter_declarations = "ParameterDeclarations",
        .query_execution_options = "QueryExecutionOptions",
        .sheets = "Sheets",
        .static_files = "StaticFiles",
        .tooltip_sheets = "TooltipSheets",
    };
};
